# Image Guidelines

Images are useful for validation, but keep them clean, relevant, and safe to publish.

## Recommended Images

Good images for this repository:

- real BIOS Setup screenshots showing the unlocked menu
- AMIBCP screenshots showing the modified menu tree
- CPU-Z Mainboard tab screenshots showing board model, chipset/southbridge, BIOS version, and BIOS date
- CPU-Z Memory tab screenshots showing applied memory frequency and timings
- memory stability test screenshots
- your own photo of the tested motherboard
- your own photo of the board model marking, if serial numbers are hidden

## Images To Avoid

Do not commit:

- seller listing images unless you have permission or a clear license
- product/catalog photos copied from marketplaces
- board photos copied from external databases unless the specific image has a clear reusable license
- screenshots exposing serial numbers, UUIDs, MAC addresses, or full firmware dumps
- images containing private account names, addresses, chats, order numbers, or tracking data
- screenshots of proprietary tool downloads or license-restricted binaries

If a board photo has a serial sticker or QR code, crop or blur that part before publishing.

## Timing Proof Screenshots

For memory timing validation, the best evidence is:

```text
CPU-Z > Memory
```

Useful fields:

- DRAM Frequency
- Channel #
- CAS# Latency
- RAS# to CAS# Delay
- RAS# Precharge
- Cycle Time
- Row Refresh Cycle Time
- Command Rate

If showing the memory module itself, prefer `CPU-Z > SPD` only if serial numbers are hidden.

## Suggested Filenames

Use descriptive lowercase names:

```text
screenshots/amibcp-before-memory-timings-outside-memory-configuration.jpg
screenshots/amibcp-memory-timings-visible-yes.png
screenshots/cpu-z-mainboard-q87-bios-5-11.png
screenshots/cpu-z-ddr4-2400-cl13-and-bench-experimental.png
screenshots/memtest-ddr4-2400-cl13.jpg
screenshots/real-board-jingsha-x99s-d4-plus.jpg
```

Use `experimental` in the filename when the setting has not passed long stability testing yet.

## Metadata

Before publishing photos taken with a phone, remove EXIF metadata.

At minimum, remove:

- GPS location
- camera serial data
- timestamp metadata, if privacy matters

Screenshots usually contain less metadata than phone photos, but they should still be checked before release.

## External Board Databases

It is fine to link to external board pages as references.

Example:

```text
https://theretroweb.com/motherboards/s/jingsha-x99s-d4-plus
```

Do not commit a copied board image from an external page unless the page shows a license that allows redistribution, or you have explicit permission.

If you use an externally licensed image, document the source URL, author or creditor, and license next to the image.
