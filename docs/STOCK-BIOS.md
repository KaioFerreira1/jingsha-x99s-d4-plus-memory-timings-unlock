# Stock BIOS Reference

This project can also provide a stock BIOS-region-only reference image through GitHub Releases.

The goal is to help users who cannot find an original JINGSHA X99S-D4-PLUS BIOS online.

## Important

Prefer an official vendor BIOS whenever available.

The stock reference documented here comes from the tested board dump. It is useful for comparison and recovery research, but it is still firmware from a real board.

## What Can Be Released

Allowed:

```text
BIOS region only
8 MB
```

Not allowed:

```text
Full SPI dump
16 MB full chip image
Intel ME region
Flash descriptor region
```

## Stock Reference Asset

Recommended release filename:

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_STOCK-TESTED_BIOS-REGION-ONLY.bin
```

SHA256:

```text
10E8AE30C7330AD3D3C853E4B72BAC8EC1644A255B20A35D39C4825DC871CE04
```

## Tested Firmware Identification

```text
Board:              JINGSHA X99S-D4-PLUS
FPT reported PCH:   Intel Q87 Express / 8 Series-C220
Flash chip tested:  Winbond W25Q128BV
BIOS region size:   8 MB
Full SPI size:      16 MB
```

## Why Not Full SPI?

A full SPI dump can contain board-specific or sensitive data:

- Intel ME region
- flash descriptor
- NVRAM variables
- serial/UUID-like data
- platform-specific calibration or configuration

For public distribution, BIOS-region-only is the safer boundary.

## Warning Text

Use this warning in the GitHub Release:

```text
BIOS REGION ONLY.
Stock reference from the tested JINGSHA X99S-D4-PLUS board.
Not a full SPI dump.
Do not use on a different board or firmware variant.
Keep your own full SPI backup.
External SPI programmer strongly recommended.
Use at your own risk.
```

