# Validation

The tested mod was validated in three stages.

## 1. AMIBCP Validation

The modified BIOS region opened in AMIBCP and showed:

```text
IntelRCSetup > Memory Configuration > Memory Timings & Voltage Override
```

The target submenu contained memory frequency, voltage, primary timings, and related timing controls.

## 2. Real BIOS Setup Validation

After flashing on the tested board, the real AMI Aptio Setup Utility displayed the unlocked menu under `Memory Configuration`.

The submenu opened correctly and allowed memory frequency selection.

## 3. Runtime Validation

The system booted into Windows after selecting DDR4-2400.

CPU-Z reported:

```text
DRAM Frequency: 1200.9 MHz
Effective DDR rate: ~2400 MT/s
Channel: Dual
Timings: 17-17-17-40
Command Rate: 1T
```

Later experimental timing testing also booted at DDR4-2400 with tighter primary timings:

```text
DRAM Frequency: ~1200 MHz
Effective DDR rate: ~2400 MT/s
Timings: 13-13-13-31
tRFC: 331
Command Rate: 1T
```

This tighter profile should be treated as experimental until long memory stability tests are documented.

Recommended proof screenshots:

- CPU-Z Mainboard tab showing board model, Q87 southbridge, and BIOS version
- CPU-Z Memory tab after applying the settings
- BIOS timing menu showing the selected values
- memory stability test result after the timing change

Image publishing notes are in [IMAGE-GUIDELINES.md](IMAGE-GUIDELINES.md).

## Evidence Preview

The first AMIBCP image documents the original menu-placement issue. The following images document the patched tree and real hardware validation.

| Original AMIBCP issue | Patched AMIBCP tree |
| --- | --- |
| <img src="../screenshots/amibcp-before-memory-timings-outside-memory-configuration.jpg" alt="Original AMIBCP issue: Memory Timings outside Memory Configuration" width="420"> | <img src="../screenshots/amibcp-memory-configuration-tree.png" alt="Patched AMIBCP Memory Configuration tree" width="420"> |

| AMIBCP menu entry | CPU-Z board identification |
| --- | --- |
| <img src="../screenshots/amibcp-memory-timings-visible-yes.png" alt="AMIBCP Memory Timings Show Yes" width="420"> | <img src="../screenshots/cpu-z-mainboard-q87-bios-5-11.png" alt="CPU-Z Mainboard Q87 BIOS 5.11" width="420"> |

| Real BIOS Setup | Unlocked timing controls |
| --- | --- |
| <img src="../screenshots/real-bios-memory-configuration.jpg" alt="Real BIOS Memory Configuration unlocked" width="420"> | <img src="../screenshots/real-bios-memory-timings-menu.jpg" alt="Real BIOS Memory Timings menu" width="420"> |

<img src="../screenshots/cpu-z-ddr4-2400-cl13-and-bench-experimental.png" alt="CPU-Z DDR4-2400 CL13 experimental and bench" width="840">

## Recommended Stability Tests

Before tightening timings further:

- Run MemTest86.
- Run TestMem5 or OCCT Memory in Windows.
- Change one memory parameter at a time.
- Keep notes for every bootable and stable setting.
