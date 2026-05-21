# BIOS Mod Release Policy

This repository is now structured around two use cases:

```text
1. Download the experimental BIOS region mod from GitHub Releases.
2. Rebuild the same mod from your own dump using the patcher.
```

The patcher remains the recommended path for verification and future BIOS variants.

## What Can Be Published In Releases

GitHub Releases may include an experimental **BIOS region only** image for the exact tested target:

```text
JINGSHA X99S-D4-PLUS
FPT reported platform: Intel Q87 Express / 8 Series-C220
Flash chip tested: Winbond W25Q128BV
BIOS region size: 8 MB
Full SPI size: 16 MB
```

Release filename format:

```text
JINGSHA-X99S-D4-PLUS_Q87-C220_MEMORY-TIMINGS-UNLOCK_vX.Y.Z-experimental_BIOS-REGION-ONLY.bin
```

## What Must Not Be Published

Do not publish:

- Full SPI dumps.
- Intel ME region images.
- AMIBCP.
- Intel FPT / Intel ME System Tools.
- UEFITool binaries.
- Firmware images for unverified board revisions.

## Required Release Warnings

Every BIOS binary release must clearly state:

```text
BIOS REGION ONLY.
Experimental.
Tested only on JINGSHA X99S-D4-PLUS with FPT reporting Intel Q87 Express / 8 Series-C220.
Do not flash if your board or firmware identification differs.
External SPI programmer strongly recommended.
Use at your own risk.
```

## Required Hashes

Every release must include SHA256 for:

- released BIOS region image
- original tested BIOS region, when documented
- patched `Platform` body
- patched `AMITSESetupData` body

## Recommended User Flow

Before flashing the release image, users should:

1. Dump their own BIOS.
2. Extract `Platform` and `AMITSESetupData`.
3. Compare module hashes with `docs/COMPATIBILITY.md`.
4. Open the release image in AMIBCP.
5. Confirm the unlocked menu appears.
6. Keep a recovery method ready.

## Why BIOS Region Only

The full SPI image can contain board-specific or sensitive data:

- Intel ME region
- descriptor layout
- NVRAM
- UUIDs
- serial data
- MAC-related data, depending on platform

Publishing only the BIOS region reduces, but does not eliminate, risk.

