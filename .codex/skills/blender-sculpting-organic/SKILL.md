---
name: blender-sculpting-organic
description: Choose and execute organic Blender modeling workflows for creatures, characters, faces and natural forms, including blockout, sculpt detail, remesh strategy and transition to retopology when animation is required.
---

# Blender Sculpting Organic

Use for forms whose shape is primarily organic rather than manufactured.

## Decision

Use sculpting when:
- continuous surface flow matters;
- forms are anatomical/natural;
- boolean hard-surface construction would be awkward.

Avoid sculpting critical mechanical interfaces that require exact dimensions.

## Workflow

1. Block large forms.
2. Establish silhouette and proportions.
3. Add secondary anatomical/forms.
4. Add tertiary detail last.
5. Evaluate from all reference angles.
6. Decide whether retopology is required.

## Remesh

Voxel/remesh is useful during shape exploration but can destroy:
- precise dimensions;
- clean UVs;
- animation topology.

Do not keep remeshing after critical details/interfaces are established.

## Animation

If deformation is required:
- sculpt for form;
- retopologize for deformation;
- project/bake detail;
- rig the retopologized mesh.

Do not rig a chaotic high-density sculpt unless the task explicitly justifies it.
