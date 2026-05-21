# Known Issues And Limitations

## Tested Scope Is Narrow

The patch was tested on one physical JINGSHA X99S-D4-PLUS board. Other boards or BIOS builds may have different offsets, menu structures, or AMITSESetupData records.

## Memory Stability Is Not Guaranteed

Unlocking the menu does not guarantee that every memory frequency or timing will be stable.

The validated baseline was:

```text
DDR4-2400
17-17-17-40
Command Rate 1T
Voltage Auto
Dual channel
```

Run memory stability tests before tightening timings further.

## AMIBCP Display Truncation

AMIBCP may visually truncate long menu names in the tree. This does not necessarily indicate a bad patch.

## Voltage Field Behavior

On the tested board, `Memory Voltage = 0` appears to behave as auto/default. Do not assume the scale or voltage behavior without checking board behavior.

## Recovery Requirement

A failed memory setting can usually be recovered with CMOS reset. A bad flash may require an external SPI programmer.

## No Universal BIOS Image

This repository does not provide a universal ready-to-flash ROM.

The published BIOS-region-only release asset is experimental and only for the exact tested target. Users can also generate their own modified image from their own firmware dump.
