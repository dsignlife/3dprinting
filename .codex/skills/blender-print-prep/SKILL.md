---
name: blender-print-prep
description: Prepare Blender geometry for FDM printing: millimeter scale, manifold solids, wall/clearance preservation, bed orientation, STL/3MF export and independent mesh validation.
---

# Blender Print Prep

Use only after design geometry is complete.

## Validate
- real dimensions;
- critical interfaces;
- applied/understood scale;
- manifold/watertight solid where appropriate;
- normals;
- disconnected shells;
- zero-thickness geometry;
- helpers/cutters excluded.

## Orientation
Choose intended print orientation based on:
- layer strength;
- supports;
- first-layer contact;
- surface quality;
- critical holes/interfaces.

## Export
Prefer saving `.blend` source first.
Export intended printable bodies only.
Validate the exported artifact independently when tooling exists.

Do not silently resize holes, pockets, shafts, inserts, magnet seats or mating features during repair.
