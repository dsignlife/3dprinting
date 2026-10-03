---
name: blender-deformation-design
description: Plan mesh, bone and shape-key deformation so animated organic objects bend cleanly and retain volume, with joint testing before animation polish.
---

# Blender Deformation Design

Use when the mesh itself must bend or morph.

## Before rigging

Check:
- topology density;
- loop placement;
- rest pose;
- symmetry;
- scale;
- joint locations.

## Bone deformation

Use for articulated volumetric motion.

Test extreme poses early:
- elbow/knee flexion;
- shoulder/hip rotation;
- wrist/ankle;
- spine/neck.

## Weight strategy

Start broad, then correct:
- collapsing joints;
- candy-wrapper twisting;
- unintended neighboring influence;
- volume loss.

## Shape keys

Use corrective shape keys when weights alone cannot preserve the intended form efficiently.

## Gate

Do not animate polished motion until the rig can pass a small pose-test suite without obvious deformation failures.
