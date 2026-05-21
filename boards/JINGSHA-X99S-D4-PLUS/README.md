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

| Original AMIBCP issue | Patched AMIBCP tree |
| --- | --- |
| <img src="../../screenshots/amibcp-before-memory-timings-outside-memory-configuration.jpg" alt="Original AMIBCP issue: Memory Timings outside Memory Configuration" width="420"> | <img src="../../screenshots/amibcp-memory-configuration-tree.png" alt="Patched AMIBCP Memory Configuration tree" width="420"> |

| AMIBCP menu entry | CPU-Z board identification |
| --- | --- |
| <img src="../../screenshots/amibcp-memory-timings-visible-yes.png" alt="AMIBCP Memory Timings Show Yes" width="420"> | <img src="../../screenshots/cpu-z-mainboard-q87-bios-5-11.png" alt="CPU-Z Mainboard Q87 BIOS 5.11" width="420"> |

| Real BIOS Setup | Unlocked timing controls |
| --- | --- |
| <img src="../../screenshots/real-bios-memory-configuration.jpg" alt="Real BIOS Memory Configuration unlocked" width="420"> | <img src="../../screenshots/real-bios-memory-timings-menu.jpg" alt="Real BIOS Memory Timings menu" width="420"> |

| CPU-Z DDR4-2400 CL13 experimental |
| --- |
| <img src="../../screenshots/cpu-z-ddr4-2400-cl13-and-bench-experimental.png" alt="CPU-Z DDR4-2400 CL13 experimental and bench" width="840"> |

## Related Files

- [Patch profile](../../patches/JINGSHA-X99S-D4-PLUS-memory-timings.json)
- [Patch notes](../../patch-notes/JINGSHA-X99S-D4-PLUS-2026-05-21.md)
- [Method](../../docs/METHOD.md)
- [Compatibility](../../docs/COMPATIBILITY.md)
- [Firmware identification](../../docs/FIRMWARE-IDENTIFICATION.md)
- [Known issues](../../docs/KNOWN-ISSUES.md)
