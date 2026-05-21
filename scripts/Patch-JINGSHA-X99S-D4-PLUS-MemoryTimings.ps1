[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$PlatformBody,

    [Parameter(Mandatory = $true)]
    [string]$AmitseSetupDataBody,

    [string]$OutputDirectory = ".\patched",

    [switch]$AllowOffsetMatch
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Expected = @{
    PlatformSize = 637920
    AmitseSize = 489816
    PlatformSha256 = "05559A64A4E5BB125C9740AB7C6B49A665201F35CEEA08CC07F62C8EBB69E88B"
    AmitseSha256 = "E687C9E53CED3779D99BA69B15456AAEC012DB67F1BB470D094796E962284C76"
}

function Resolve-InputFile {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Input file not found: $Path"
    }
    return (Resolve-Path -LiteralPath $Path).Path
}

function Assert-Bytes {
    param(
        [byte[]]$Data,
        [int]$Offset,
        [byte[]]$ExpectedBytes,
        [string]$Label
    )

    if ($Offset + $ExpectedBytes.Length -gt $Data.Length) {
        throw "$Label exceeds input size"
    }

    for ($i = 0; $i -lt $ExpectedBytes.Length; $i++) {
        if ($Data[$Offset + $i] -ne $ExpectedBytes[$i]) {
            throw ("Unexpected byte at {0} + 0x{1:X}: expected {2}, got {3}" -f `
                $Label, $i, $ExpectedBytes[$i].ToString("X2"), $Data[$Offset + $i].ToString("X2"))
        }
    }
}

function Set-Bytes {
    param(
        [byte[]]$Data,
        [int]$Offset,
        [byte[]]$Value
    )

    for ($i = 0; $i -lt $Value.Length; $i++) {
        $Data[$Offset + $i] = $Value[$i]
    }
}

function Format-ByteString {
    param([byte[]]$Value)
    return (($Value | ForEach-Object { $_.ToString("X2") }) -join " ")
}

$platformPath = Resolve-InputFile $PlatformBody
$amitsePath = Resolve-InputFile $AmitseSetupDataBody
$resolvedOut = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputDirectory)

New-Item -ItemType Directory -Path $resolvedOut -Force | Out-Null

$platform = [IO.File]::ReadAllBytes($platformPath)
$amitse = [IO.File]::ReadAllBytes($amitsePath)

if ($platform.Length -ne $Expected.PlatformSize) {
    throw "Unexpected Platform body size: $($platform.Length). Expected: $($Expected.PlatformSize)"
}

if ($amitse.Length -ne $Expected.AmitseSize) {
    throw "Unexpected AMITSESetupData body size: $($amitse.Length). Expected: $($Expected.AmitseSize)"
}

$platformHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $platformPath).Hash.ToUpperInvariant()
$amitseHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $amitsePath).Hash.ToUpperInvariant()

if (-not $AllowOffsetMatch) {
    if ($platformHash -ne $Expected.PlatformSha256) {
        throw "Platform SHA256 mismatch. This script is fail-closed. Use -AllowOffsetMatch only after manual review."
    }
    if ($amitseHash -ne $Expected.AmitseSha256) {
        throw "AMITSESetupData SHA256 mismatch. This script is fail-closed. Use -AllowOffsetMatch only after manual review."
    }
}

$title = [byte[]](0x69, 0x10)
$titlePlus2 = [byte[]](0x6B, 0x10)
$targetEntry = [byte[]](0x94, 0x00)
$visibleAttach = [byte[]](0x8E, 0x00)

$feTargetOffset = 0x5A16
$feQid1Offset = 0x4E20E
$feQid2Offset = 0x4E256
$plQid1PromptOffset = 0x37E12
$plQid2PromptOffset = 0x37E9F

Assert-Bytes $amitse $feTargetOffset ([byte[]](0x81,0x00,0x00,0x00,0x69,0x10,0x94,0x00,0x1E,0x00)) "AMITSE target menu entry"
Assert-Bytes $amitse $feQid1Offset ([byte[]](0x00,0x00,0x34,0x0C,0x00,0x00,0x00,0x00,0x00,0x00,0x06,0x00,0x8E,0x00,0xFF,0xFF)) "AMITSE QuestionId C34 record"
Assert-Bytes $amitse $feQid2Offset ([byte[]](0x00,0x00,0x35,0x0C,0x00,0x00,0x00,0x00,0x00,0x00,0x06,0x00,0x8E,0x00,0xFF,0xFF)) "AMITSE QuestionId C35 record"
Assert-Bytes $platform $plQid1PromptOffset ([byte[]](0x6E,0x10,0x6F,0x10,0x34,0x0C)) "Platform visible Memory Frequency C34"
Assert-Bytes $platform $plQid2PromptOffset ([byte[]](0x6E,0x10,0x6F,0x10,0x35,0x0C)) "Platform visible Memory Frequency C35"

$changes = New-Object System.Collections.Generic.List[string]

Set-Bytes $amitse ($feTargetOffset + 8) $visibleAttach
$changes.Add(("AMITSE 0x{0:X}: target parent 1E 00 -> {1}" -f ($feTargetOffset + 8), (Format-ByteString $visibleAttach)))

foreach ($qidOffset in @($feQid1Offset, $feQid2Offset)) {
    Set-Bytes $amitse ($qidOffset + 10) ([byte[]](0x01,0x00))
    Set-Bytes $amitse ($qidOffset + 14) $targetEntry
    Set-Bytes $amitse ($qidOffset + 18) ([byte[]](0x01,0x00,0x00,0x00))
    Set-Bytes $amitse ($qidOffset + 22) $titlePlus2
    Set-Bytes $amitse ($qidOffset + 50) $title
    $changes.Add(("AMITSE 0x{0:X}: patched QuestionId navigation record" -f $qidOffset))
}

Set-Bytes $platform $plQid1PromptOffset ($title + $titlePlus2)
$changes.Add(("Platform 0x{0:X}: C34 prompt/help -> {1} {2}" -f $plQid1PromptOffset, (Format-ByteString $title), (Format-ByteString $titlePlus2)))

Set-Bytes $platform $plQid2PromptOffset ($title + $titlePlus2)
$changes.Add(("Platform 0x{0:X}: C35 prompt/help -> {1} {2}" -f $plQid2PromptOffset, (Format-ByteString $title), (Format-ByteString $titlePlus2)))

$platformOut = Join-Path $resolvedOut "pl_memorytimings_mod.bin"
$amitseOut = Join-Path $resolvedOut "fe_memorytimings_mod.bin"
$reportOut = Join-Path $resolvedOut "patch_report.txt"

[IO.File]::WriteAllBytes($platformOut, $platform)
[IO.File]::WriteAllBytes($amitseOut, $amitse)

$hashes = Get-FileHash -Algorithm SHA256 -LiteralPath $platformPath, $amitsePath, $platformOut, $amitseOut

$report = New-Object System.Collections.Generic.List[string]
$report.Add("JINGSHA X99S-D4-PLUS Memory Timings unlock patch")
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
$report.Add("AMITSE patched: $amitseOut")
$report.Add("")
$report.Add("SHA256")
foreach ($hash in $hashes) {
    $report.Add("$($hash.Hash)  $($hash.Path)")
}

[IO.File]::WriteAllLines($reportOut, $report, [Text.Encoding]::ASCII)

Write-Host "Patch complete."
Write-Host "Platform patched: $platformOut"
Write-Host "AMITSE patched:   $amitseOut"
Write-Host "Report:           $reportOut"

