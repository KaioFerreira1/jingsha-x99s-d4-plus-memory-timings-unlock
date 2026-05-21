[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$PlatformBody,

    [Parameter(Mandatory = $true)]
    [string]$AmitseSetupDataBody,

    [string]$PatchProfile = ".\patches\JINGSHA-X99S-D4-PLUS-memory-timings.json",

    [string]$OutputDirectory = ".\patched",

    [switch]$AllowOffsetMatch
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-File {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "File not found: $Path"
    }
    return (Resolve-Path -LiteralPath $Path).Path
}

function Convert-HexStringToBytes {
    param([string]$Hex)

    $clean = ($Hex -replace '\s+', ' ').Trim()
    if ($clean.Length -eq 0) {
        return [byte[]]@()
    }

    $parts = $clean.Split(' ')
    $bytes = New-Object byte[] $parts.Count
    for ($i = 0; $i -lt $parts.Count; $i++) {
        $bytes[$i] = [Convert]::ToByte($parts[$i], 16)
    }
    return $bytes
}

function Convert-HexOffsetToInt {
    param([string]$Offset)

    return [Convert]::ToInt32(($Offset -replace '^0x', ''), 16)
}

function Format-ByteString {
    param([byte[]]$Value)

    return (($Value | ForEach-Object { $_.ToString("X2") }) -join " ")
}

function Assert-Bytes {
    param(
        [byte[]]$Data,
        [int]$Offset,
        [byte[]]$Expected,
        [string]$Label
    )

    if ($Offset + $Expected.Length -gt $Data.Length) {
        throw "$Label exceeds module size"
    }

    for ($i = 0; $i -lt $Expected.Length; $i++) {
        if ($Data[$Offset + $i] -ne $Expected[$i]) {
            throw ("Unexpected byte at {0} + 0x{1:X}: expected {2}, got {3}" -f `
                $Label, $i, $Expected[$i].ToString("X2"), $Data[$Offset + $i].ToString("X2"))
        }
    }
}

function Set-Bytes {
    param(
        [byte[]]$Data,
        [int]$Offset,
        [byte[]]$Value
    )

    if ($Offset + $Value.Length -gt $Data.Length) {
        throw "Write at 0x$($Offset.ToString('X')) exceeds module size"
    }

    for ($i = 0; $i -lt $Value.Length; $i++) {
        $Data[$Offset + $i] = $Value[$i]
    }
}

$profilePath = Resolve-File $PatchProfile
$platformPath = Resolve-File $PlatformBody
$amitsePath = Resolve-File $AmitseSetupDataBody
$outDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputDirectory)

$profile = Get-Content -Raw -LiteralPath $profilePath | ConvertFrom-Json

New-Item -ItemType Directory -Path $outDir -Force | Out-Null

$moduleData = @{
    platform = [IO.File]::ReadAllBytes($platformPath)
    amitseSetupData = [IO.File]::ReadAllBytes($amitsePath)
}

$modulePaths = @{
    platform = $platformPath
    amitseSetupData = $amitsePath
}

foreach ($moduleKey in @("platform", "amitseSetupData")) {
    $module = $profile.modules.$moduleKey
    $data = $moduleData[$moduleKey]
    $path = $modulePaths[$moduleKey]

    if ($data.Length -ne [int]$module.size) {
        throw "$($module.name) size mismatch. Expected $($module.size), got $($data.Length)."
    }

    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash.ToUpperInvariant()
    if (-not $AllowOffsetMatch -and $hash -ne $module.sha256.ToUpperInvariant()) {
        throw "$($module.name) SHA256 mismatch. Use -AllowOffsetMatch only after manual review."
    }
}

$changes = New-Object System.Collections.Generic.List[string]

foreach ($check in $profile.checks) {
    $offset = Convert-HexOffsetToInt $check.offset
    $expected = Convert-HexStringToBytes $check.bytes
    Assert-Bytes -Data $moduleData[$check.module] -Offset $offset -Expected $expected -Label $check.label
}

foreach ($write in $profile.writes) {
    $offset = Convert-HexOffsetToInt $write.offset
    $bytes = Convert-HexStringToBytes $write.bytes
    Set-Bytes -Data $moduleData[$write.module] -Offset $offset -Value $bytes
    $changes.Add(("{0} {1}: {2} -> {3}" -f $write.module, $write.offset, $write.label, (Format-ByteString $bytes)))
}

$platformOut = Join-Path $outDir $profile.modules.platform.outputFile
$amitseOut = Join-Path $outDir $profile.modules.amitseSetupData.outputFile
$reportOut = Join-Path $outDir "patch_report.txt"

[IO.File]::WriteAllBytes($platformOut, $moduleData.platform)
[IO.File]::WriteAllBytes($amitseOut, $moduleData.amitseSetupData)

$hashes = Get-FileHash -Algorithm SHA256 -LiteralPath $platformPath, $amitsePath, $platformOut, $amitseOut

$report = New-Object System.Collections.Generic.List[string]
$report.Add($profile.name)
$report.Add("")
$report.Add("Profile")
$report.Add($profilePath)
$report.Add("")
$report.Add("Inputs")
$report.Add("Platform: $platformPath")
$report.Add("AMITSESetupData: $amitsePath")
$report.Add("")
$report.Add("Changes")
foreach ($change in $changes) {
    $report.Add("- $change")
}
$report.Add("")
$report.Add("Outputs")
$report.Add("Platform patched: $platformOut")
$report.Add("AMITSESetupData patched: $amitseOut")
$report.Add("")
$report.Add("SHA256")
foreach ($hash in $hashes) {
    $report.Add("$($hash.Hash)  $($hash.Path)")
}

[IO.File]::WriteAllLines($reportOut, $report, [Text.Encoding]::ASCII)

Write-Host "Patch complete."
Write-Host "Platform patched:      $platformOut"
Write-Host "AMITSESetupData patch: $amitseOut"
Write-Host "Report:                $reportOut"

