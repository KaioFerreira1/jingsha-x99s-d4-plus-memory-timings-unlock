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

## Recommended Stability Tests

Before tightening timings further:

- Run MemTest86.
- Run TestMem5 or OCCT Memory in Windows.
- Change one memory parameter at a time.
- Keep notes for every bootable and stable setting.

