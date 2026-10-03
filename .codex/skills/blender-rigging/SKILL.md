---
name: blender-rigging
description: Rig Blender objects and characters through MCP using armatures, parenting, weights, IK/FK, constraints and deformation checks.
---

# Blender Rigging

Choose the simplest rig:
- object parenting for simple rigid assemblies;
- armature + rigid bone parenting for articulated machines;
- deforming armature + weights for organic meshes;
- shape keys for localized morphs/correctives.

## Workflow
1. Inspect scale/orientation.
2. Apply transforms where appropriate.
3. Create armature aligned to anatomy/mechanism.
4. Name bones consistently.
5. Build parent-child hierarchy.
6. Add only needed controls/constraints.
7. Parent meshes appropriately.
8. Test extreme poses.
9. Fix weights/intersections.
10. Preserve a clean rest pose.

## IK/FK
Use IK for planted endpoints or mechanical chains.
Use FK for direct rotational arcs.
Avoid constraint cycles and unplanned IK/FK popping.

## Validation
Check scale, bone axes, rest pose, control isolation, deformation quality and save/reload stability.
