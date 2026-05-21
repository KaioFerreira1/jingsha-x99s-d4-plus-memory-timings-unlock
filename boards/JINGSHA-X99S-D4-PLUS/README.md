# JINGSHA X99S-D4-PLUS Board Profile

## Unlock Target

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

## Tested Configuration

```text
Motherboard: JINGSHA X99S-D4-PLUS
FPT platform: Intel Q87 Express / 8 Series-C220
CPU:         Intel Xeon E5-2680 v4
Memory:      2x8 GB DDR4 Hynix 2133
Result:      DDR4-2400 after unlock
```

## Patch Targets

```text
Platform
GUID: ABBCE13D-E25A-4D9F-A1F9-2F7710786892

AMITSESetupData
GUID: FE612B72-203C-47B1-8560-A66D946EB371
```

## Validation Evidence

- [Real BIOS Memory Configuration](../../screenshots/real-bios-memory-configuration.jpg)
- [Real BIOS Memory Timings Menu](../../screenshots/real-bios-memory-timings-menu.jpg)

## Related Files

- [Patch profile](../../patches/JINGSHA-X99S-D4-PLUS-memory-timings.json)
- [Patch notes](../../patch-notes/JINGSHA-X99S-D4-PLUS-2026-05-21.md)
- [Method](../../docs/METHOD.md)
- [Compatibility](../../docs/COMPATIBILITY.md)
- [Firmware identification](../../docs/FIRMWARE-IDENTIFICATION.md)
- [Known issues](../../docs/KNOWN-ISSUES.md)
