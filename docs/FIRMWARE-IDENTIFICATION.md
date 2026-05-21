# Firmware Identification

The tested board is sold/identified as:

```text
JINGSHA X99S-D4-PLUS
```

However, the Intel Flash Programming Tool used during the original dump identified the firmware platform/PCH as:

```text
Intel Q87 Express / 8 Series-C220
```

This is important because some Chinese "X99" boards do not identify exactly like retail Intel X99/C612 platforms in firmware tools.

## Tested Dump Details

```text
FPT version:       Intel Flash Programming Tool 9.1.10.1000
Detected platform: Intel Q87 Express / 8 Series-C220
Flash chip:        Winbond W25Q128BV
Full SPI size:     16 MB
BIOS region size:  8 MB
Flash descriptor:  Valid
```

Region layout reported by FPT:

```text
Descriptor: 0x000000 - 0x000FFF
ME:         0x001000 - 0x7FFFFF
BIOS:       0x800000 - 0xFFFFFF
```

## Why This Matters

Do not assume compatibility based only on the seller name or "X99" label.

For this project, the safest compatibility check is still the extracted module hash:

```text
Platform body SHA256:
05559A64A4E5BB125C9740AB7C6B49A665201F35CEEA08CC07F62C8EBB69E88B

AMITSESetupData body SHA256:
E687C9E53CED3779D99BA69B15456AAEC012DB67F1BB470D094796E962284C76
```

If your board is sold as JINGSHA X99S-D4-PLUS but reports a different firmware platform or has different module hashes, treat it as a different target until manually reviewed.

