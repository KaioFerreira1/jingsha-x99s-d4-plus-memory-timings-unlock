# FAQ

## Can I flash a BIOS file from this repository?

No. This repository does not include BIOS images.

It only provides documentation and a patcher that works with your own extracted module bodies.

## Why not publish a ready-to-flash BIOS?

Because firmware images can contain board-specific data and can brick incompatible boards.

This project is safer as a reproducible patch method:

```text
your dump -> extracted modules -> patcher -> your modified image
```

## My board is also X99. Will this work?

Not automatically.

The patch is only tested on JINGSHA X99S-D4-PLUS. Other X99 boards may have similar menus, but offsets and QuestionIds can differ.

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

