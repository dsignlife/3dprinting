---
name: blender-printability-director
description: Make FDM-oriented design decisions before Blender execution: orientation, anisotropic strength, splits, supports, clearances, wall strategy and which animation concepts can or cannot become physical mechanisms.
---

# Blender Printability Director

Use when the Blender object will be printed.

## Distinguish two goals

### Digital animation
Bones/keyframes/physics can make the digital object move.

### Physical movement
A printed object needs actual:
- hinges;
- pins;
- joints;
- clearances;
- flexures;
- bearings;
- assembled parts.

Never confuse a Blender armature with a printable mechanical joint.

## Design decisions

Consider:
- target orientation;
- layer-direction strength;
- wall thickness;
- unsupported features;
- bridging;
- support access/removal;
- bed fit;
- part splitting;
- assembly;
- clearances.

## Moving printed objects

For a physically articulated print:
- define separate printable bodies;
- define real pivot geometry;
- choose assembled vs print-in-place;
- specify clearances;
- check collision range.

## Validation

Before export require:
- critical dimensions;
- manifold/watertight geometry;
- body count;
- clearances;
- intended orientation;
- independent exported mesh check.
