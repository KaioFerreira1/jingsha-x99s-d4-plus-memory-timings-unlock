# Glossary

## AMIBCP

AMI BIOS Configuration Program. Used here to inspect the BIOS Setup tree and confirm whether hidden menus exist.

## AMITSESetupData

An AMI firmware component involved in Setup menu structure. In this project, it is patched so the hidden memory timings form becomes reachable from the visible menu tree.

## BIOS Region

The firmware region that contains most UEFI/BIOS modules. This is different from a full SPI dump.

## Body

The raw contents of a firmware section extracted by UEFITool. This project patches extracted module bodies, not a full BIOS image directly.

## Dump

A backup copy of firmware read from the motherboard flash chip.

## Fail-Closed

The patcher refuses to modify files unless hashes, sizes, and expected bytes match.

## FPT

Intel Flash Programming Tool. Often used to dump or flash Intel firmware regions. This repository does not include it.

## GUID

A unique identifier used by UEFI firmware to identify files and sections.

## IFR

Internal Forms Representation. AMI Setup menus are represented as IFR data inside firmware modules.

## Platform

The firmware module that contains the IntelRCSetup forms used by this mod.

## SPI Dump

A full flash chip image. It may contain ME firmware, NVRAM, serials, UUIDs, and other board-specific data. Do not publish it publicly.

## UEFIReplace

A LongSoft UEFITool utility used to replace firmware section bodies in a BIOS image.

