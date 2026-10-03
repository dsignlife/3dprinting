---
name: mesh-print-validation
description: Validate Blender exports for FDM printing with independent dimension, topology, manifold, normals, disconnected-body, and exported-file checks.
version: 1.0.0
---

# Mesh Print Validation

Use after modeling and before declaring a file ready for slicing.

## 1. Dimension checks

Compare:
- final bounding dimensions;
- CRITICAL feature dimensions;
- specified clearances;
- hole/pocket dimensions;
- center spacing.

Fail validation if a protected interface differs from the requirement.

## 2. Topology checks

Where applicable verify:
- watertight closed solid;
- manifold edges;
- consistent outward normals;
- no duplicate/degenerate faces;
- no accidental internal shells;
- no unintended disconnected components;
- no zero-thickness geometry.

## 3. Object hygiene

Verify:
- helpers/cutters are not included in export;
- expected number of printable bodies;
- intended bed-facing geometry exists;
- scale/export units are correct.

## 4. Exported artifact validation

Validate the exported STL/3MF itself when possible, not only the Blender source.

The toolbox provides:

```bash
mesh-python
```

with:
- trimesh
- manifold3d
- numpy

Example STL inspection:

```bash
mesh-python - <<'PY'
import trimesh
m = trimesh.load("/workspace/output/model.stl", force="mesh")
print("watertight:", m.is_watertight)
print("bounds:", m.bounds)
print("extents:", m.extents)
print("components:", len(m.split(only_watertight=False)))
PY
```

Do not automatically repair an exported mesh if the repair could alter a CRITICAL interface without re-measuring it afterward.

## 5. Result

Return:

`VALIDATION_PASS`

with measured evidence,

or:

`VALIDATION_FAIL`

with each failing gate and discrepancy.

Do not silently loosen requirements to create a pass.
