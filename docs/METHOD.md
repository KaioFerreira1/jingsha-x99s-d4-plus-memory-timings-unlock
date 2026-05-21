# Method

This method unlocks a hidden AMI Setup form by patching two firmware components:

- `Platform`
- `AMITSESetupData`

The stock BIOS already contains the target form:

```text
Memory Timings & Voltage Override
```

The problem is that the form is not properly exposed through the visible Setup navigation tree.

## Target Path

Expected unlocked path:

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

## Extract Required Bodies

Open your BIOS region dump in UEFITool and extract:

### Platform

```text
Platform
  PE32 image section
    Extract body -> pl.bin
```

GUID:

```text
ABBCE13D-E25A-4D9F-A1F9-2F7710786892
```

### AMITSESetupData

```text
AMITSESetupData
  Freeform subtype GUID section
    Extract body -> fe.bin
```

GUID:

```text
FE612B72-203C-47B1-8560-A66D946EB371
```

## Patch Modules

The patch itself is described in a JSON profile:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

That file contains the expected hashes, validation bytes, write offsets, and replacement bytes. The PowerShell script only applies that profile.

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1 `
  -PlatformBody .\work\pl.bin `
  -AmitseSetupDataBody .\work\fe.bin `
  -OutputDirectory .\work\patched
```

The script validates:

- Known module sizes.
- Known input hashes.
- Expected bytes at every patch offset.

If validation fails, the script stops without modifying files.

## Rebuild BIOS Region

Using `UEFIReplace 0.28.0`:

```powershell
UEFIReplace.exe .\bios_region_dump.bin ABBCE13D-E25A-4D9F-A1F9-2F7710786892 10 .\work\patched\pl_memorytimings_mod.bin -o .\work\bios_step1_platform.bin

UEFIReplace.exe .\work\bios_step1_platform.bin FE612B72-203C-47B1-8560-A66D946EB371 18 .\work\patched\fe_memorytimings_mod.bin -o .\work\bios_region_memory_timings_unlocked.bin
```

Section types:

- `10`: PE32 image section
- `18`: Freeform subtype GUID section

## Validate Before Flashing

Open the rebuilt BIOS image in AMIBCP.

Expected result:

```text
IntelRCSetup
  Memory Configuration
    Memory Timings & Voltage Override
```

The submenu should contain:

- DIMM profile
- Memory Frequency
- Memory Voltage
- Command Timing
- CAS Latency
- tRP
- tRCD
- tRAS
- tWR
- tRFC
- tRRD
- tRTP
- tWTR
- tFAW
- tRC
- tCWL
