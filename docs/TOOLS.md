# Tools

This repository does not redistribute firmware tools. Obtain them separately and verify their source.

## Used For This Mod

### AMIBCP 5

Used to inspect the AMI Setup tree and confirm whether the hidden menu exists.

AMIBCP is proprietary and is not included in this repository.

### UEFITool / UEFIReplace

Used to extract and replace firmware module bodies.

Recommended source:

- https://github.com/LongSoft/UEFITool

The tested rebuild flow used `UEFIReplace 0.28.0`.

### IFR Extractor

Used to inspect AMI IFR forms from the `Platform` module.

Recommended source:

- https://github.com/LongSoft/IFRExtractor-RS

### Hex Editor

Used for manual verification of byte offsets.

Any reliable hex editor can be used.

## Not Included

Do not commit these tools to the repository:

- AMIBCP
- Intel FPT / Intel ME System Tools
- UEFITool binaries
- IFRExtractor binaries

