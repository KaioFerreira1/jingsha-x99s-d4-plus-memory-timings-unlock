# JINGSHA X99S-D4-PLUS Memory Timings Unlock

Unlocks the hidden **Memory Timings & Voltage Override** menu in the AMI Aptio BIOS used by the JINGSHA X99S-D4-PLUS motherboard.

This project documents a tested BIOS Setup mod for exposing:

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

The menu exists in the stock firmware, but it is not reachable from the visible BIOS Setup tree. The mod patches the Setup structure so the hidden form becomes accessible.

## Status

Tested on one physical board:

- Motherboard: JINGSHA X99S-D4-PLUS
- BIOS UI: AMI Aptio Setup Utility 2023
- CPU: Intel Xeon E5-2680 v4
- Memory: 2x8 GB DDR4 Hynix 2133
- Confirmed result: DDR4 running at 2400 MT/s after unlock

This is not a universal BIOS image. The script is intentionally fail-closed and only patches module bodies that match the known tested build.

## What This Repository Includes

- Documentation of the method and patch targets.
- A PowerShell patcher for the tested `Platform` and `AMITSESetupData` module bodies.
- Patch notes with offsets, GUIDs, hashes, and validation details.
- Screenshots showing the unlocked menu on real hardware.

## What This Repository Does Not Include

- No BIOS dumps.
- No ready-to-flash firmware images.
- No AMIBCP binaries.
- No Intel FPT / Intel ME System Tools binaries.
- No UEFITool binaries.
- No automated flashing script.

You must use your own firmware dump and your own legally obtained tools.

## High-Level Method

1. Dump your own BIOS.
2. Open the dump in AMIBCP and confirm the hidden menu exists.
3. Extract these module bodies:
   - `Platform` PE32 body
   - `AMITSESetupData` freeform subtype GUID body
4. Run the patcher on those two extracted bodies.
5. Replace the patched bodies back into a copy of your BIOS image.
6. Validate the modified image in AMIBCP before considering any flash.

See [docs/METHOD.md](docs/METHOD.md) for the full workflow.
See [docs/DUMPING.md](docs/DUMPING.md) for backup and privacy notes.

## Quick Start

Create a working folder and place the extracted bodies there:

```text
work/pl.bin
work/fe.bin
```

Run the patcher:

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

The script refuses to patch if the input modules do not match the tested build.

## Rebuilding The BIOS Image

Using LongSoft `UEFIReplace` 0.28.0:

```powershell
UEFIReplace.exe .\bios_region_dump.bin ABBCE13D-E25A-4D9F-A1F9-2F7710786892 10 .\work\patched\pl_memorytimings_mod.bin -o .\work\bios_step1_platform.bin

UEFIReplace.exe .\work\bios_step1_platform.bin FE612B72-203C-47B1-8560-A66D946EB371 18 .\work\patched\fe_memorytimings_mod.bin -o .\work\bios_region_memory_timings_unlocked.bin
```

Then open `bios_region_memory_timings_unlocked.bin` in AMIBCP and verify the menu appears under:

```text
IntelRCSetup > Memory Configuration
```

## Safety

Firmware modification can brick your motherboard. Do not flash anything unless you understand recovery procedures and have a full SPI backup. An external programmer is strongly recommended.

Read [DISCLAIMER.md](DISCLAIMER.md) and [docs/FLASHING-SAFETY.md](docs/FLASHING-SAFETY.md) before using this project.

## Evidence

The tested board successfully exposed the menu in the real BIOS Setup and booted DDR4 at 2400 MT/s.

Screenshots are in [screenshots](screenshots).

Included evidence:

- [real-bios-memory-configuration.jpg](screenshots/real-bios-memory-configuration.jpg)
- [real-bios-memory-timings-menu.jpg](screenshots/real-bios-memory-timings-menu.jpg)

## Credits

This work was inspired by the public LGA2011-3/X99 memory timings unlock method documented at:

- https://e5450.com/socket-2011-3/razblokiruem-upravlenie-tajmingami/

The values in this repository were recalculated from a real JINGSHA X99S-D4-PLUS dump. They are not copied from another board.
