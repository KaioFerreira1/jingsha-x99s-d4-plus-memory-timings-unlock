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

This project may provide an experimental BIOS-region-only file through GitHub Releases.

You can either use the release asset or generate the same modification from your own dump.

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
- You want a universal no-checks ROM for any X99 board.
- You do not have a backup or recovery method.

## Option A: Use The Experimental Release

This is the simple path. You do not need to run the scripts if you are using the published BIOS-region-only file.

```text
1. Download the BIOS-region-only file from GitHub Releases
2. Verify its SHA256 hash
3. Open it in AMIBCP
4. Confirm the unlocked menu exists
5. Make sure your board/firmware identification matches
6. Only then decide whether flashing is worth the risk
```

Expected release file:

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_MEMORY-TIMINGS-UNLOCK_v0.1.0-experimental_BIOS-REGION-ONLY.bin
```

Expected SHA256:

```text
E886AC2F4EE250B2DFDC103948C819D74125B16910E6EBEDDBC4F4CEE9FAF901
```

## Option B: Reproduce The Patch With The Script

Use this path if you want to understand or audit the modification instead of only using the release asset.

Start with [docs/SCRIPT-WALKTHROUGH.md](docs/SCRIPT-WALKTHROUGH.md), then use [docs/METHOD.md](docs/METHOD.md) for extraction and BIOS-region rebuild details.

For another motherboard, do not reuse this board's offsets directly. Use [docs/PORTING-GUIDE.md](docs/PORTING-GUIDE.md).

## Optional: Stock BIOS Reference

If you need the tested stock BIOS-region-only reference, check:

```text
release-assets/stock-tested-bios-region/RELEASE-NOTES.md
docs/STOCK-BIOS.md
```

Expected stock asset:

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_STOCK-TESTED_BIOS-REGION-ONLY.bin
```

Expected SHA256:

```text
10E8AE30C7330AD3D3C853E4B72BAC8EC1644A255B20A35D39C4825DC871CE04
```

## Rebuild Summary For Option B

```text
1. Dump your own BIOS
2. Open it in AMIBCP and confirm the hidden menu exists
3. Extract two module bodies with UEFITool
4. Run the patcher
5. Replace the patched bodies into a copy of your BIOS region
6. Open the modified image in AMIBCP
```

## Files You Need To Extract For Option B

From your BIOS region image:

```text
Platform PE32 body        -> pl.bin
AMITSESetupData body      -> fe.bin
```

If you do not know how to extract these files, read:

[docs/SCRIPT-WALKTHROUGH.md](docs/SCRIPT-WALKTHROUGH.md) and [docs/METHOD.md](docs/METHOD.md).

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
3. docs/SCRIPT-WALKTHROUGH.md
4. docs/METHOD.md
5. docs/COMPATIBILITY.md
6. docs/FIRMWARE-IDENTIFICATION.md
7. docs/BIOS-MOD-RELEASE.md
8. docs/STOCK-BIOS.md
9. patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
10. docs/FLASHING-SAFETY.md
11. docs/FAQ.md
12. docs/PORTING-GUIDE.md
13. docs/IMAGE-GUIDELINES.md
14. docs/REFERENCES.md
```
