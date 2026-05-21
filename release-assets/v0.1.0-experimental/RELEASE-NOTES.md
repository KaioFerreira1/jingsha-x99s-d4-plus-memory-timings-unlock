# JINGSHA X99S-D4-PLUS Memory Timings Unlock v0.1.0-experimental

Experimental BIOS region mod for:

```text
JINGSHA X99S-D4-PLUS
FPT reported platform: Intel Q87 Express / 8 Series-C220
```

## Published Asset

This file is published as a GitHub Release asset:

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_MEMORY-TIMINGS-UNLOCK_v0.1.0-experimental_BIOS-REGION-ONLY.bin
```

## SHA256

```text
E886AC2F4EE250B2DFDC103948C819D74125B16910E6EBEDDBC4F4CEE9FAF901
```

## Changes

Unlocks:

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

Patched modules:

```text
Platform
AMITSESetupData
```

## Tested Result

```text
DDR4-2400 confirmed in CPU-Z
Menu visible in real BIOS Setup
```

## Compatibility Requirement

Use only if your board matches:

```text
Board:             JINGSHA X99S-D4-PLUS
FPT reported PCH:  Intel Q87 Express / 8 Series-C220
BIOS region size:  8 MB
Flash size:        16 MB
```

Recommended additional check:

```text
Platform body SHA256:
05559A64A4E5BB125C9740AB7C6B49A665201F35CEEA08CC07F62C8EBB69E88B

AMITSESetupData body SHA256:
E687C9E53CED3779D99BA69B15456AAEC012DB67F1BB470D094796E962284C76
```

## Flashing Warning

This is not a full SPI image.

```text
BIOS REGION ONLY.
Experimental.
Bad flash can brick the board.
Keep your own full SPI backup.
External SPI programmer strongly recommended.
Use at your own risk.
```
