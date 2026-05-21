# JINGSHA X99S-D4-PLUS Patch Notes

Date: 2026-05-21

## Goal

Expose the hidden menu:

```text
Memory Timings & Voltage Override
```

under:

```text
IntelRCSetup > Memory Configuration
```

## Modules

```text
Platform
GUID: ABBCE13D-E25A-4D9F-A1F9-2F7710786892
Body: PE32 image section

AMITSESetupData
GUID: FE612B72-203C-47B1-8560-A66D946EB371
Body: Freeform subtype GUID section
```

## Input Module Hashes

```text
pl.bin
SHA256: 05559A64A4E5BB125C9740AB7C6B49A665201F35CEEA08CC07F62C8EBB69E88B
Size:   637920 bytes

fe.bin
SHA256: E687C9E53CED3779D99BA69B15456AAEC012DB67F1BB470D094796E962284C76
Size:   489816 bytes
```

## Output Module Hashes

```text
pl_memorytimings_mod.bin
SHA256: 96B4F9E8C08C8412D4E5A9D869518ED02F836BAF5A3C4D9081C9B8D2FF21A102

fe_memorytimings_mod.bin
SHA256: 6EE656EB49BBB31A6DA0BFB30B2F63258B66322471EC7E198DCFB391C4FE037B
```

## Key IFR Values

```text
Visible Memory Frequency QuestionIds: 0xC34 / 0xC35
Hidden menu FormId:                    0x81
Hidden menu title string token:         69 10
Hidden menu help string token:          6B 10
Hidden target entry:                    94 00
Visible attach/reference:               8E 00
```

## Byte Changes

```text
AMITSESetupData:
0x5A1E: 1E 00 -> 8E 00

0x4E218: 06 -> 01
0x4E21C: FF FF -> 94 00
0x4E220: 09 -> 01
0x4E224: 6F -> 6B
0x4E240: 6E -> 69

0x4E260: 06 -> 01
0x4E264: FF FF -> 94 00
0x4E268: 09 -> 01
0x4E26C: 6F -> 6B
0x4E288: 6E -> 69

Platform:
0x37E12: 6E -> 69
0x37E14: 6F -> 6B
0x37E9F: 6E -> 69
0x37EA1: 6F -> 6B
```

Machine-readable patch profile:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

## Rebuild Commands

```powershell
UEFIReplace.exe .\bios_region_dump.bin ABBCE13D-E25A-4D9F-A1F9-2F7710786892 10 .\pl_memorytimings_mod.bin -o .\bios_step1_platform.bin

UEFIReplace.exe .\bios_step1_platform.bin FE612B72-203C-47B1-8560-A66D946EB371 18 .\fe_memorytimings_mod.bin -o .\bios_region_memory_timings_unlocked.bin
```
