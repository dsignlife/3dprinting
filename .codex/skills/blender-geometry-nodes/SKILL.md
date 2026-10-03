---
name: blender-geometry-nodes
description: Create Geometry Nodes systems for procedural repetition, scattering, curves, pipes, cables, parametric forms and reusable model controls.
---

# Blender Geometry Nodes

Use when procedural construction is more maintainable than manual duplication.

Good uses:
- arrays/repetition;
- scatter;
- cables and pipes;
- patterned surfaces;
- adjustable parametric structures;
- instance-based detail.

## Rules
- expose meaningful inputs;
- name important nodes/groups;
- keep geometry readable and modular;
- prefer instances until real geometry is required;
- realize instances only when downstream operations need it;
- avoid excessive node complexity for a one-off simple shape.

For printing, inspect the realized final geometry before export.
Procedural geometry must still become a valid printable mesh.
