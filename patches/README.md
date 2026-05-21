# Patch Profiles

Patch profiles keep the important firmware-specific data outside the PowerShell code.

The script reads a JSON profile containing:

- supported board name
- module GUIDs
- expected module sizes and hashes
- validation bytes
- write offsets
- replacement bytes

Current profile:

```text
JINGSHA-X99S-D4-PLUS-memory-timings.json
```

The PowerShell script should stay boring. The JSON file is where reviewers can audit what the patch changes.

For another motherboard, create a new JSON profile instead of editing this one in place. See [../docs/PORTING-GUIDE.md](../docs/PORTING-GUIDE.md).
