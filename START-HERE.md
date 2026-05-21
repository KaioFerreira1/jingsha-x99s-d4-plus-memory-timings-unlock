# Start Here

This page is the simple path through the project.

## What This Mod Does

The stock JINGSHA X99S-D4-PLUS BIOS already contains this hidden menu:

```text
Memory Timings & Voltage Override
```

This project makes that menu reachable from:

```text
IntelRCSetup > Memory Configuration
```

After the unlock, the tested board was able to select DDR4-2400 from BIOS Setup.

## What This Mod Does Not Do

This project does not provide a BIOS file to flash.

You must generate your own modified BIOS from your own dump.

It also does not add:

- ReBar
- microcode updates
- Intel ME updates
- custom logos
- GOP drivers
- VROC drivers

## Who Should Use This

Use this if:

- You have a JINGSHA X99S-D4-PLUS.
- Your extracted module hashes match this project.
- Your firmware identification is consistent with the tested dump, or you understand how to review differences.
- You know how to recover a bad BIOS flash.
- You understand that firmware flashing can brick the board.

Do not use this if:

- Your board is a different X99 model.
- Your hashes do not match and you cannot manually audit the patch.
- You want a ready-to-flash ROM.
- You do not have a backup or recovery method.

## Basic Workflow

```text
1. Dump your own BIOS
2. Open it in AMIBCP and confirm the hidden menu exists
3. Extract two module bodies with UEFITool
4. Run the patcher
5. Replace the patched bodies into a copy of your BIOS region
6. Open the modified image in AMIBCP
7. Only then decide whether flashing is worth the risk
```

## Files You Need To Extract

From your BIOS region image:

```text
Platform PE32 body        -> pl.bin
AMITSESetupData body      -> fe.bin
```

If you do not know how to extract these files, read:

```text
docs/METHOD.md
```

## Run The Patcher

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1 `
  -PlatformBody .\work\pl.bin `
  -AmitseSetupDataBody .\work\fe.bin `
  -OutputDirectory .\work\patched
```

If your BIOS build matches the tested one, the script generates:

```text
work/patched/pl_memorytimings_mod.bin
work/patched/fe_memorytimings_mod.bin
work/patched/patch_report.txt
```

If your BIOS build does not match, the script stops.

## What To Check In AMIBCP

After rebuilding the BIOS image, open it in AMIBCP.

You should see:

```text
IntelRCSetup
  Memory Configuration
    Memory Timings & Voltage Override
```

Inside that menu, you should see options like:

```text
DIMM profile
Memory Frequency
Memory Voltage
CAS Latency
tRP
tRCD
tRAS
tRFC
tCWL
```

## Recommended Reading Order

```text
1. README.md
2. START-HERE.md
3. docs/COMPATIBILITY.md
4. docs/METHOD.md
5. docs/FIRMWARE-IDENTIFICATION.md
6. patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
7. docs/FLASHING-SAFETY.md
8. docs/FAQ.md
```
