# JINGSHA X99S-D4-PLUS Memory Timings Unlock

Unlocks the hidden **Memory Timings & Voltage Override** menu in the AMI Aptio BIOS used by the JINGSHA X99S-D4-PLUS motherboard.

If you are new to this project, read [START-HERE.md](START-HERE.md) first.

## Attention

This project is for the **JINGSHA X99S-D4-PLUS** BIOS variant tested here.

- Do not use this as a generic X99 BIOS mod.
- Do not flash anything before validating the generated image in AMIBCP.
- Do not publish or share full SPI dumps from your own board.
- Keep a full SPI backup and have an external programmer available.
- BIOS mod binaries, when provided, are experimental BIOS-region-only release assets.

This project provides an experimental BIOS mod and documents a reproducible BIOS Setup patch for exposing:

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

The menu exists in the stock firmware, but it is not reachable from the visible BIOS Setup tree. The mod patches the Setup structure so the hidden form becomes accessible.

## Status

Tested on one physical board:

- Motherboard: JINGSHA X99S-D4-PLUS
- Firmware/PCH reported by FPT: Intel Q87 Express / 8 Series-C220
- BIOS UI: AMI Aptio Setup Utility 2023
- CPU: Intel Xeon E5-2680 v4
- Memory: 2x8 GB DDR4 Hynix 2133
- Confirmed result: DDR4 running at 2400 MT/s after unlock

This is not a universal BIOS image. The release BIOS region and the patcher target only the known tested build.

## Features

- Unlocks the hidden memory timings menu.
- Provides an experimental BIOS-region-only mod through GitHub Releases.
- Keeps the process reproducible from the user's own dump.
- Validates exact module sizes and SHA256 hashes before patching.
- Documents GUIDs, offsets, QuestionIds, and output hashes.
- Includes real BIOS Setup evidence from the tested board.

This project does not update microcodes, Intel ME, ReBar, GOP, VROC, logos, or other firmware components.

## Compatibility

| Board | Status | Notes |
| --- | --- | --- |
| JINGSHA X99S-D4-PLUS | Tested working | Menu unlocked and DDR4-2400 confirmed |
| Other JINGSHA X99 variants | Untested | Do not assume compatible |
| MACHINIST/KLLISRE/HUANANZHI X99 variants | Untested | Similar methods may apply, but offsets can differ |

See [docs/COMPATIBILITY.md](docs/COMPATIBILITY.md).

## What This Repository Includes

- Documentation of the method and patch targets.
- Release notes and hashes for the experimental BIOS region mod.
- A readable JSON patch profile for the tested `Platform` and `AMITSESetupData` module bodies.
- A small PowerShell wrapper plus a generic patch executor.
- Patch notes with offsets, GUIDs, hashes, and validation details.
- Screenshots showing the unlocked menu on real hardware.

## What This Repository Does Not Include

- No full SPI dumps.
- No firmware binaries committed into the Git tree.
- No AMIBCP binaries.
- No Intel FPT / Intel ME System Tools binaries.
- No UEFITool binaries.
- No automated flashing script.

BIOS mod binaries, if published, belong in GitHub Releases as explicit experimental assets. You still need your own backup and legally obtained tools.

## Repository Layout

```text
boards/          Board-specific profile and validation summary
docs/            Method, compatibility, safety, tools, validation
patches/         Human-readable JSON patch profile
patch-notes/     Exact offsets, GUIDs, hashes, and byte changes
scripts/         Fail-closed patcher
screenshots/     Real BIOS Setup evidence
release-assets/  Release notes, hashes, and upload checklist
```

## Downloading The BIOS Mod

The experimental BIOS mod should be published as a GitHub Release asset, not committed directly to the repository.

Expected release asset:

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_MEMORY-TIMINGS-UNLOCK_v0.1.0-experimental_BIOS-REGION-ONLY.bin
```

SHA256:

```text
E886AC2F4EE250B2DFDC103948C819D74125B16910E6EBEDDBC4F4CEE9FAF901
```

Release notes are in:

```text
release-assets/v0.1.0-experimental/RELEASE-NOTES.md
```

Read [docs/BIOS-MOD-RELEASE.md](docs/BIOS-MOD-RELEASE.md) before publishing or flashing a release binary.

## Reproducible Patch Method

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
See [docs/FIRMWARE-IDENTIFICATION.md](docs/FIRMWARE-IDENTIFICATION.md) for the Q87 / 8 Series-C220 detection note.
See [docs/GLOSSARY.md](docs/GLOSSARY.md) if the firmware terms are unfamiliar.

## Patcher Quick Start

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

The actual patch data is in:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

Read that file if you want to audit the offsets and replacement bytes without reading PowerShell code.

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
Read [docs/KNOWN-ISSUES.md](docs/KNOWN-ISSUES.md) before changing memory settings.

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
