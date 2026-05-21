# Compatibility

This repository currently targets one tested board and one known firmware build.

## Tested Working

| Item | Value |
| --- | --- |
| Board | JINGSHA X99S-D4-PLUS |
| BIOS UI | AMI Aptio Setup Utility 2023 |
| CPU | Intel Xeon E5-2680 v4 |
| Memory | 2x8 GB DDR4 Hynix 2133 |
| Result | Hidden memory timings menu unlocked |
| Runtime validation | DDR4-2400 confirmed in CPU-Z |

## Required Module Matches

The patcher expects these extracted module body hashes:

```text
Platform PE32 body
SHA256: 05559A64A4E5BB125C9740AB7C6B49A665201F35CEEA08CC07F62C8EBB69E88B
Size:   637920 bytes

AMITSESetupData freeform body
SHA256: E687C9E53CED3779D99BA69B15456AAEC012DB67F1BB470D094796E962284C76
Size:   489816 bytes
```

If your hashes differ, stop and review manually. Do not force the patch unless you understand the IFR and AMITSESetupData structure for your BIOS.

## Untested

- Other JINGSHA X99 boards.
- Other X99S-D4-PLUS BIOS builds.
- Other AliExpress X99 boards with similar menus.
- Dual CPU C612 boards.

Similar methods may work on related AMI Aptio X99 firmware, but the offsets and QuestionIds must be recalculated from that board's own dump.

## Compatibility Rule

Treat every BIOS dump as a separate target unless the extracted module hashes match exactly.

