# Dumping Notes

This project does not provide dumping or flashing tools.

Before any modification, create backups using a method appropriate for your board and firmware lock state.

## Recommended Backups

Keep at least:

```text
full_spi_original.bin
bios_region_original.bin
```

Store a copy outside the machine being modified.

## Full SPI vs BIOS Region

The full SPI image may contain board-specific data such as:

- Intel ME region
- NVRAM variables
- Serial numbers
- UUIDs
- MAC addresses, depending on platform

Do not publish full SPI dumps.

The BIOS region is usually safer to analyze, but it can still contain system-specific data. Do not publish firmware dumps unless you have audited them.

## Public Reports

For public issues or pull requests, share hashes and screenshots instead of firmware binaries.

Useful data:

```text
Platform body SHA256
AMITSESetupData body SHA256
BIOS region size
Board name
CPU model
Memory configuration
AMIBCP screenshots
```

