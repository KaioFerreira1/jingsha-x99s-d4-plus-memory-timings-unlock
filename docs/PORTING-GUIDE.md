# Porting Guide

This project can be used as a reference for other boards, but the included patch profile is only for the tested JINGSHA X99S-D4-PLUS BIOS.

Do not apply the JINGSHA X99S-D4-PLUS offsets to another motherboard without recalculating them from that board's firmware.

## What Can Be Reused

The generic patch engine can be reused:

```text
scripts/Apply-BiosModulePatch.ps1
```

It reads a JSON profile, validates input files, applies byte writes, and produces patched module bodies.

For another board, the reusable idea is:

```text
board-specific JSON profile + extracted module bodies -> patched module bodies
```

## What Must Be Recreated

For another board, you must create new board-specific data:

- board name and firmware identification
- module GUIDs if they differ
- extracted module body sizes
- extracted module body hashes
- IFR form IDs
- QuestionIds for the visible anchor item
- AMITSESetupData navigation records
- validation bytes
- write offsets
- replacement bytes
- rebuild commands and section types
- AMIBCP validation screenshots
- real hardware validation notes, if tested

## Recommended Directory Pattern

Create a new profile instead of editing the JINGSHA profile:

```text
patches/YOUR-BOARD-memory-timings.json
```

Create a small wrapper:

```text
scripts/Patch-YOUR-BOARD-MemoryTimings.ps1
```

The wrapper should only point to the new JSON profile and call:

```text
scripts/Apply-BiosModulePatch.ps1
```

## Porting Workflow

### 1. Dump The Firmware

Get a clean dump of the target board.

Keep:

- full SPI backup for recovery
- BIOS-region-only image for analysis
- hashes of every input file

Do not publish full SPI dumps. They can contain board-specific data.

### 2. Find The Hidden Form

Use IFR extraction and AMIBCP to locate the hidden form you want to expose.

For this project, the hidden form was:

```text
Memory Timings & Voltage Override
```

The important values were:

```text
hidden form ID
title string token
help string token
target setup entry
```

Those values can be different on another board.

### 3. Find A Visible Anchor

Find a visible menu item near the desired location in the Setup tree.

For this project, the visible anchor was under:

```text
IntelRCSetup > Memory Configuration
```

The visible anchor QuestionIds were:

```text
0xC34
0xC35
```

Another board can use different QuestionIds.

### 4. Map The Setup Navigation Records

Locate the matching records in `AMITSESetupData`.

You need to understand which bytes represent:

- the visible anchor
- the hidden target entry
- the parent/group relationship
- visibility or navigation flags
- title/help string tokens

Do not rely only on the same offsets from this repository. Offsets are firmware-build-specific.

### 5. Create Validation Checks

Before writing bytes, define checks that prove the script is looking at the expected data.

Each check should include:

```json
{
  "module": "amitseSetupData",
  "offset": "0x0000",
  "bytes": "AA BB CC DD",
  "label": "Human-readable reason"
}
```

Good checks make the script fail before damaging the wrong file.

### 6. Create Writes

After the checks are known, define the exact writes:

```json
{
  "module": "amitseSetupData",
  "offset": "0x0000",
  "bytes": "11 22 33 44",
  "label": "Human-readable change"
}
```

Keep labels specific enough that a reviewer understands why each write exists.

### 7. Run The Generic Script With The New Profile

Example:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Apply-BiosModulePatch.ps1 `
  -PlatformBody .\work\other-board\pl.bin `
  -AmitseSetupDataBody .\work\other-board\fe.bin `
  -PatchProfile .\patches\YOUR-BOARD-memory-timings.json `
  -OutputDirectory .\work\other-board\patched
```

Do not use the JINGSHA wrapper for another board.

### 8. Replace Modules Back Into The BIOS Region

Use the section types from the target board's own module layout.

For this JINGSHA project they were:

```text
Platform PE32 image section       -> section type 10
AMITSESetupData freeform section  -> section type 18
```

Confirm these from the target board before rebuilding.

### 9. Validate Before Any Flash

Open the rebuilt BIOS region in AMIBCP.

Confirm:

- the intended menu appears in the expected place
- the menu opens
- unrelated Setup pages still appear normal
- the rebuilt BIOS region has the expected size
- hashes are documented

Only real hardware testing can prove boot behavior.

## Compatibility Rule

Matching board names are not enough.

A safe port needs matching analysis of:

- firmware build
- module hashes
- IFR structure
- AMITSESetupData records
- rebuilt BIOS validation

If any of those differ, treat it as a new target.

## Contribution Requirements

If submitting support for another board, include:

- board name printed on PCB
- firmware source and date, if known
- PCH or firmware identification
- full list of input hashes
- module GUIDs and section types
- patch profile
- patch notes with offsets and rationale
- AMIBCP validation screenshots
- clear statement whether it was flashed and tested

Do not submit full SPI dumps, private identifiers, or external tool binaries.
