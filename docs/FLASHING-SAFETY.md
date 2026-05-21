# Flashing Safety

This repository does not provide a flash script.

The mod can look correct in AMIBCP and still be risky to flash. Firmware flashing always carries a brick risk.

## Minimum Safety Checklist

Before flashing any modified firmware:

- Keep a full SPI dump of the original chip.
- Keep a BIOS-region backup.
- Verify the modified image opens correctly in AMIBCP.
- Re-extract the modified image and verify the patched bodies are present.
- Have an external programmer available.
- Know the physical flash chip model.
- Do not flash during unstable power conditions.

## Do Not Flash

Do not flash if:

- The patcher reported a validation failure.
- Your module hashes differ and you did not manually audit the offsets.
- AMIBCP cannot open the modified image.
- The menu tree looks corrupted.
- You do not have a recovery path.

## Recovery

For this class of board, external SPI recovery is often the safest recovery method. Keep the original full SPI backup off the system being modified.

