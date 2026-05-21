# Script Walkthrough

This document explains how to use the optional patch script and what each step does.

The script is not required if you are using the published BIOS-region-only release asset. It exists so the modification can be reproduced and audited from extracted module bodies.

## What The Script Does

The script patches two extracted firmware module bodies:

```text
Platform              -> PE32 image section body
AMITSESetupData       -> Freeform subtype GUID section body
```

It does not:

- patch a full BIOS image directly
- replace modules back into the BIOS image
- flash the motherboard
- download external tools

The script only applies the byte changes described in:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

## Required Inputs

You need these files extracted from a matching JINGSHA X99S-D4-PLUS BIOS region:

```text
work/pl.bin
work/fe.bin
```

Expected meaning:

```text
pl.bin -> Platform PE32 image section body
fe.bin -> AMITSESetupData freeform section body
```

Expected input hashes:

```text
Platform:
05559A64A4E5BB125C9740AB7C6B49A665201F35CEEA08CC07F62C8EBB69E88B

AMITSESetupData:
E687C9E53CED3779D99BA69B15456AAEC012DB67F1BB470D094796E962284C76
```

If these hashes do not match, stop and review the BIOS manually.

## Step 1: Extract The Module Bodies

Open the BIOS-region-only image in UEFITool.

Extract `Platform`:

```text
Platform
  PE32 image section
    Extract body -> work/pl.bin
```

GUID:

```text
ABBCE13D-E25A-4D9F-A1F9-2F7710786892
```

Extract `AMITSESetupData`:

```text
AMITSESetupData
  Freeform subtype GUID section
    Extract body -> work/fe.bin
```

GUID:

```text
FE612B72-203C-47B1-8560-A66D946EB371
```

## Step 2: Review The Patch Profile

Open:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

The profile defines:

- board name
- module GUIDs
- expected input sizes
- expected input SHA256 hashes
- validation bytes
- write offsets
- replacement bytes

The important safety rule is that `checks` are validated before `writes` are applied.

## Step 3: Run The Wrapper Script

From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1 `
  -PlatformBody .\work\pl.bin `
  -AmitseSetupDataBody .\work\fe.bin `
  -OutputDirectory .\work\patched
```

Expected outputs:

```text
work/patched/pl_memorytimings_mod.bin
work/patched/fe_memorytimings_mod.bin
work/patched/patch_report.txt
```

## What Happens Internally

The wrapper script:

```text
scripts/Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1
```

loads the board-specific JSON profile and calls the generic engine:

```text
scripts/Apply-BiosModulePatch.ps1
```

The generic script then:

1. Resolves the input file paths.
2. Loads the JSON profile.
3. Reads both module bodies as bytes.
4. Checks module sizes.
5. Checks SHA256 hashes.
6. Checks expected bytes at every listed offset.
7. Applies the replacement bytes.
8. Writes patched module bodies.
9. Writes `patch_report.txt` with changed offsets and hashes.

If any validation fails, the script stops.

## Step 4: Rebuild The BIOS Region

Use `UEFIReplace 0.28.0` to replace the patched bodies into a copy of the BIOS region:

```powershell
UEFIReplace.exe .\bios_region_dump.bin ABBCE13D-E25A-4D9F-A1F9-2F7710786892 10 .\work\patched\pl_memorytimings_mod.bin -o .\work\bios_step1_platform.bin

UEFIReplace.exe .\work\bios_step1_platform.bin FE612B72-203C-47B1-8560-A66D946EB371 18 .\work\patched\fe_memorytimings_mod.bin -o .\work\bios_region_memory_timings_unlocked.bin
```

Section types:

```text
10 -> PE32 image section
18 -> Freeform subtype GUID section
```

## Step 5: Validate The Rebuilt Image

Before flashing anything, open the rebuilt BIOS region in AMIBCP.

Expected path:

```text
IntelRCSetup
  Memory Configuration
    Memory Timings & Voltage Override
```

Also verify:

- the image opens normally in AMIBCP
- the menu tree is not corrupted
- the BIOS region size remains expected
- the SHA256 of the generated file is recorded

## Common Failures

### SHA256 mismatch

The extracted body is not identical to the tested firmware body.

Do not force the patch unless you have manually reviewed the IFR and AMITSESetupData structure.

### Unexpected byte at offset

The file may be from another BIOS build, the wrong section was extracted, or the offset does not contain the expected record.

### AMIBCP does not show the menu

The module replacement step may have failed, the wrong section type may have been used, or the BIOS uses a different setup navigation structure.

## About `-AllowOffsetMatch`

`-AllowOffsetMatch` skips the SHA256 check, but it still validates expected bytes at every patch offset.

Use it only after manual review. It is not a compatibility bypass for unknown boards.
