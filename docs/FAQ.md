# FAQ

## Can I flash a BIOS file from this repository?

The Git tree does not include BIOS images.

This project provides an experimental BIOS-region-only image through GitHub Releases. That file is only for the exact tested target and must be verified before use.

The safer path is still to use the patcher with your own extracted module bodies.

## Why not commit the BIOS file directly to the repository?

Because firmware images are binary release artifacts, not source files. Keeping them in Git makes the repository harder to audit and easier to misuse.

The repository keeps documentation, patch profiles, hashes, and scripts in Git. The optional BIOS region mod belongs in GitHub Releases with warnings and checksums.

## Why keep the patcher if a BIOS region release exists?

Because the patcher is the reproducible method:

```text
your dump -> extracted modules -> patcher -> your modified image
```

It also lets users verify whether their BIOS matches the tested build before trusting a release binary.

## My board is also X99. Will this work?

Not automatically.

The patch is only tested on JINGSHA X99S-D4-PLUS. Other X99 boards may have similar menus, but offsets and QuestionIds can differ.

## Can I adapt the script for another board?

Yes, but only the generic patch engine should be reused directly.

Create a new JSON profile with that board's own hashes, offsets, validation bytes, and replacement bytes. Do not use the JINGSHA X99S-D4-PLUS profile on another board.

See [PORTING-GUIDE.md](PORTING-GUIDE.md).

## The patcher says my hash does not match. What now?

Stop.

That means your extracted module is not identical to the tested firmware. You need to manually analyze your BIOS before patching.

Do not force the patch unless you understand the IFR and AMITSESetupData structure.

## What does fail-closed mean?

It means the script refuses to patch if the expected bytes, sizes, or hashes do not match.

This is intentional. It prevents applying known offsets to the wrong BIOS.

## Does unlocking the menu guarantee DDR4-2400 or better?

No.

The tested board booted DDR4-2400, but memory stability depends on CPU IMC, memory sticks, board routing, voltage behavior, and timings.

## What should I test after changing memory settings?

Use memory stability tests before tightening timings further:

- MemTest86
- TestMem5
- OCCT Memory

Change one setting at a time and keep notes.

## What tools do I need?

At minimum:

- AMIBCP 5 for Setup tree inspection
- UEFITool / UEFIReplace for extract and replace
- A way to dump your own BIOS
- A recovery method if flash fails

See:

```text
docs/TOOLS.md
```

## What does AMITSESetupData do here?

In this mod, `Platform` contains the IFR forms and text references. `AMITSESetupData` controls how those forms are exposed in the visible Setup tree.

Both need to be patched for the menu to appear and open correctly.
