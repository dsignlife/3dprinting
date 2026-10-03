---
name: blender-hard-surface
description: Hard-surface Blender modeling for brackets, housings, enclosures, machinery, robots and manufactured forms using booleans, bevels, symmetry and clean edge language.
---

# Blender Hard Surface

Build in this order:
1. primary silhouette;
2. functional cutouts/interfaces;
3. secondary panels/bosses/recesses;
4. edge treatment;
5. tertiary cosmetic detail.

Prefer primitives, numeric dimensions, Mirror, Array, Boolean and Bevel.

## Boolean discipline
- Apply scale where required.
- Name cutters `CUT_*`.
- Avoid fragile coplanar boolean boundaries.
- Inspect topology after final booleans.
- Never change a critical hole/pocket size just to make a boolean succeed.

## Animation-aware modeling
If parts may move:
- keep independently moving pieces separate;
- place origins at real pivots;
- preserve hierarchy;
- do not join rigid moving pieces unnecessarily.

## Print awareness
Preserve wall thickness, fit clearances, manifold geometry and intentional split lines.
