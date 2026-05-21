# Release Checklist

Use this checklist before publishing or tagging a release.

- [ ] No BIOS dumps are committed.
- [ ] No modified BIOS images are committed to Git.
- [ ] No AMIBCP binaries are committed.
- [ ] No Intel FPT / Intel ME System Tools binaries are committed.
- [ ] No UEFITool binaries are committed.
- [ ] The patcher runs successfully against the known tested module bodies.
- [ ] Patch notes include input hashes, output hashes, offsets, and GUIDs.
- [ ] README states that BIOS binaries are experimental release assets.
- [ ] Screenshots do not expose private serial numbers or unique firmware data.
- [ ] Flashing safety notes are present.
- [ ] Release assets do not include full SPI images.
- [ ] Release BIOS image is BIOS-region-only.
- [ ] Release filename includes `BIOS-REGION-ONLY`.
- [ ] Compatibility notes mention exact module hashes.
- [ ] Release notes include SHA256 for every binary asset.
- [ ] Stock BIOS reference, if released, is BIOS-region-only and not full SPI.
