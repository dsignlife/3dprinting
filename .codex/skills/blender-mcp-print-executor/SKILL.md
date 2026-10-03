---
name: blender-mcp-print-executor
description: Execute printable-object designs in Blender through MCP using precise numeric modeling, clean modifier/boolean workflows, protected interfaces, and deterministic export/validation.
version: 1.0.0
---

# Blender MCP Print Executor

Use this skill whenever Codex needs to create or modify printable geometry in Blender.

The task may come from:
- a pasted screenshot;
- user measurements;
- a written design request;
- a `PRINTABLE_OBJECT_SPEC`.

Your job is to execute accurately in Blender, not silently redesign the part.

## 1. Inspect first

Before editing:
- discover currently available Blender MCP tools;
- inspect the active Blender scene;
- identify relevant objects;
- confirm scene units;
- identify whether the task is new-build or modification;
- inspect actual dimensions of existing geometry.

Never assume object names or scene state.

## 2. Use exact geometry

For fit-critical features:
- set dimensions numerically;
- use explicit datums/origins;
- use exact coordinates;
- use named cutter geometry;
- preserve CRITICAL dimensions.

Do not globally scale a finished part if it contains protected interfaces unless explicitly requested.

## 3. Preferred Blender construction strategy

Prefer:
1. primitives for primary forms;
2. numeric transforms;
3. Mirror/Array for symmetry and repetition;
4. Boolean Difference for holes/pockets/slots;
5. Solidify when a true shell is appropriate;
6. Bevel/chamfer for controlled edge treatment;
7. curves for sweeps/tubes when appropriate;
8. sculpt/remesh only for genuinely organic geometry.

Keep critical mechanical interfaces outside destructive sculpt/remesh regions where practical.

## 4. Booleans

For cut features:
- name cutters `CUT_*`;
- verify cutter dimensions before use;
- apply object scale when required for predictable boolean behavior;
- keep modifiers non-destructive until geometry is checked;
- do not change hole/pocket size just to make a boolean succeed.

## 5. Naming

Use:
- `PART_*` for printable bodies
- `CUT_*` for boolean cutters
- `DATUM_*` for helpers/empties
- `REF_*` for references

Do not export helper/cutter/reference objects as printable bodies.

## 6. Transform discipline

Before final validation:
- inspect scale;
- apply scale when required by modifiers/export;
- preserve deliberate position/rotation unless the task says to bake it;
- ensure intended bed-facing surface/orientation is correct.

## 7. Geometry integrity

Check/fix as appropriate:
- non-manifold edges;
- duplicate vertices;
- degenerate geometry;
- inverted/inconsistent normals;
- unintended internal faces;
- accidental disconnected shells;
- zero-thickness surfaces;
- unapplied modifiers required for final geometry.

A model that looks correct is not automatically printable.

## 8. Numeric verification

Measure relevant values directly from Blender data:
- overall X/Y/Z;
- hole diameters;
- center-to-center spacing;
- pocket depth;
- wall thickness specified by the task;
- fit clearances;
- number of final printable bodies.

Do not rely on screenshot estimates.

## 9. Save and export

For non-trivial work:
- save a `.blend` source in `models/`;
- validate;
- export only intended printable bodies to `output/`.

For STL:
- verify export scale;
- verify file existence;
- run independent mesh validation when possible.

For 3MF:
- preserve body/material separation only when requested and supported by the downstream workflow.

## 10. Completion evidence

Return:
- source `.blend` path;
- exported file path(s);
- measured final dimensions;
- validation result;
- any deviations/conflicts;
- whether the model is ready for slicing.

Never say "print-ready" when required validation was skipped.
