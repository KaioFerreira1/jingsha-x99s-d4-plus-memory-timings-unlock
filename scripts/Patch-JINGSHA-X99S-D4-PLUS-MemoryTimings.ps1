[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$PlatformBody,

    [Parameter(Mandatory = $true)]
    [string]$AmitseSetupDataBody,

    [string]$OutputDirectory = ".\patched",

    [switch]$AllowOffsetMatch
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$applyScript = Join-Path $scriptDir "Apply-BiosModulePatch.ps1"
$profile = Join-Path $repoRoot "patches\JINGSHA-X99S-D4-PLUS-memory-timings.json"

& $applyScript `
    -PlatformBody $PlatformBody `
    -AmitseSetupDataBody $AmitseSetupDataBody `
    -PatchProfile $profile `
    -OutputDirectory $OutputDirectory `
    -AllowOffsetMatch:$AllowOffsetMatch
