# v0.1.0-experimental Release Assets

This folder documents the first experimental BIOS mod release.

The `.bin` file is intentionally ignored by Git and is published manually as a GitHub Release asset.

The repository MIT license applies to the project documentation, scripts, and patch profiles. This BIOS-region image is a firmware reference artifact from the tested target and may contain vendor firmware code.

## Release Asset

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_MEMORY-TIMINGS-UNLOCK_v0.1.0-experimental_BIOS-REGION-ONLY.bin
```

## SHA256

```text
E886AC2F4EE250B2DFDC103948C819D74125B16910E6EBEDDBC4F4CEE9FAF901
```

## Target

```text
Board:               JINGSHA X99S-D4-PLUS
FPT reported PCH:    Intel Q87 Express / 8 Series-C220
Flash chip tested:   Winbond W25Q128BV
BIOS region size:    8 MB
Full SPI size:       16 MB
```

## What It Unlocks

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

## Validation

Validated by:

- AMIBCP tree inspection.
- Real BIOS Setup menu access.
- Windows boot.
- CPU-Z showing DDR4-2400.

## Warning

```text
BIOS REGION ONLY.
Experimental.
Do not flash if your board or firmware identification differs.
External SPI programmer strongly recommended.
Use at your own risk.
```
