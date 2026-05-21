# Scripts

## Recommended Entry Point

Use:

```text
Patch-JINGSHA-X99S-D4-PLUS-MemoryTimings.ps1
```

Patches the extracted `Platform` and `AMITSESetupData` module bodies from the tested JINGSHA X99S-D4-PLUS BIOS.

This file is intentionally short. It loads:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

and passes it to:

```text
Apply-BiosModulePatch.ps1
```

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

## Review The Patch

Review the JSON profile first. It is easier to audit than the script:

```text
patches/JINGSHA-X99S-D4-PLUS-memory-timings.json
```

The profile contains:

- expected module hashes
- expected bytes before patching
- write offsets
- replacement bytes
- labels explaining each change
