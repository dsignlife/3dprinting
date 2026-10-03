---
name: blender-modeling-core
description: Precise general Blender modeling through MCP: primitives, Edit Mode, modifiers, booleans, transforms, pivots, cleanup, and scene organization.
---

# Blender Modeling Core

Use Blender MCP for execution. Inspect the current scene before editing.

## Workflow
1. Inspect scene, units, object names, dimensions, transforms and current selection.
2. Establish real-world scale, origin, axes and object hierarchy.
3. Block out primary forms with primitives and numeric transforms.
4. Refine using Edit Mode or non-destructive modifiers.
5. Keep Mirror/Array/Boolean/Solidify live while iterating when practical.
6. Apply scale before operations that depend on scale.
7. Validate dimensions and topology before destructive finalization.
8. Save a `.blend` source before export.

## Precision
- Use numeric values for fit-critical geometry.
- Use explicit origins/datums rather than eyeballing.
- Re-measure after booleans, remesh, bevels or applied scale.
- Name important parts immediately.

## Cleanup
Check duplicate vertices, loose geometry, internal faces, normals,
non-manifold edges, accidental disconnected components and unexpected scale.

Discover current Blender MCP tools/schemas rather than inventing tool names.
