# Screenshots

These screenshots show validation on the tested physical JINGSHA X99S-D4-PLUS board.

See [../docs/IMAGE-GUIDELINES.md](../docs/IMAGE-GUIDELINES.md) before adding more images.

## Files

```text
amibcp-before-memory-timings-outside-memory-configuration.jpg
```

Shows the original AMIBCP issue: `Memory Configuration` is visible, but `Memory Timings & Voltage Override` appears outside that submenu. This is the problem this BIOS mod fixes.

```text
amibcp-memory-configuration-tree.png
```

Shows the patched AMIBCP tree under `IntelRCSetup > Memory Configuration`.

```text
amibcp-memory-timings-visible-yes.png
```

Shows AMIBCP listing `Memory Timings & Voltage Override` with `Show = Yes`.

```text
real-bios-memory-configuration.jpg
```

Shows the unlocked `Memory Timings & Voltage Override` entry inside:

```text
IntelRCSetup > Memory Configuration
```

```text
real-bios-memory-timings-menu.jpg
```

Shows the opened `Memory Timings & Voltage Override` submenu with `DIMM profile`, `Memory Frequency`, voltage, and timing controls.

```text
cpu-z-mainboard-q87-bios-5-11.png
```

Shows CPU-Z `Mainboard` tab with JINGSHA X99S D4 PLUS, Intel Q87 southbridge, AMI BIOS 5.11, and BIOS date `09/06/2023`.

```text
cpu-z-ddr4-2400-cl13-and-bench-experimental.png
```

Shows CPU-Z `Memory` tab after applying DDR4-2400 experimental timings, plus CPU-Z benchmark output for the tested Xeon E5-2680 v4.

## Note

Screenshots are evidence only. They are not firmware data and do not contain BIOS dumps.

Use only your own screenshots or your own board photos. Avoid committing marketplace/catalog product photos unless permission or a clear license exists.

## Preview

| Original AMIBCP issue | Patched AMIBCP tree |
| --- | --- |
| <img src="amibcp-before-memory-timings-outside-memory-configuration.jpg" alt="Original AMIBCP issue: Memory Timings outside Memory Configuration" width="420"> | <img src="amibcp-memory-configuration-tree.png" alt="Patched AMIBCP Memory Configuration tree" width="420"> |

| AMIBCP menu entry | CPU-Z board identification |
| --- | --- |
| <img src="amibcp-memory-timings-visible-yes.png" alt="AMIBCP Memory Timings Show Yes" width="420"> | <img src="cpu-z-mainboard-q87-bios-5-11.png" alt="CPU-Z Mainboard Q87 BIOS 5.11" width="420"> |

| Real BIOS Setup | Unlocked timing controls |
| --- | --- |
| <img src="real-bios-memory-configuration.jpg" alt="Real BIOS Memory Configuration unlocked" width="420"> | <img src="real-bios-memory-timings-menu.jpg" alt="Real BIOS Memory Timings menu" width="420"> |

| CPU-Z DDR4-2400 CL13 experimental |
| --- |
| <img src="cpu-z-ddr4-2400-cl13-and-bench-experimental.png" alt="CPU-Z DDR4-2400 CL13 experimental and bench" width="840"> |
