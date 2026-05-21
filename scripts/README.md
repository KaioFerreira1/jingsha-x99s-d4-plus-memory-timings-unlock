# Scripts

## Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1

Patches the extracted `Platform` and `AMITSESetupData` module bodies from the tested JINGSHA X99S-D4-PLUS BIOS.

It does not:

- Read a full BIOS image.
- Replace modules back into the BIOS.
- Flash anything.

Example:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1 `
  -PlatformBody .\work\pl.bin `
  -AmitseSetupDataBody .\work\fe.bin `
  -OutputDirectory .\work\patched
```

