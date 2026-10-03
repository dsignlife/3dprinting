---
name: blender-qa-review
description: Perform structured Blender QA after modeling, rigging or animation: scene hygiene, dimensions, topology, rigs, curves, intersections, naming and export readiness.
---

# Blender QA Review

Run before declaring work complete.

## Scene
- expected objects only;
- meaningful names;
- no accidental duplicates;
- no hidden helper exported unintentionally.

## Geometry
- dimensions correct;
- scale understood;
- normals consistent;
- no unexpected non-manifold geometry;
- no accidental disconnected shells;
- modifiers intentional.

## Rig
- rest pose valid;
- constraints not cyclic;
- weights controlled;
- rigid parts stay rigid.

## Animation
- frame range correct;
- no stray keyframes;
- pivots stable;
- loops clean;
- no obvious intersections/pops;
- Actions/NLA named sensibly.

## Export
- intended objects selected;
- transforms/export units correct;
- target format supports required animation/shape keys;
- re-import exported artifact when verification matters.
