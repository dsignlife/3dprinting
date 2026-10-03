---
name: blender-image-to-3d-director
description: Plan reconstruction of a 3D object from one or more images by classifying views, calibrating scale/camera, resolving hidden geometry, choosing modeling methods and defining measurable reference-matching gates.
---

# Blender Image-to-3D Director

Use when the user supplies photos, screenshots, sketches, concept art or model sheets and wants a 3D object.

## 1. Determine evidence quality

Rank the reference set:

### Strong
- front/side/back orthographic views;
- known dimensions;
- turntable/multiple angles.

### Medium
- several perspective photos;
- one known dimension;
- recognizable repeated/symmetric features.

### Weak
- single perspective image;
- no known scale;
- hidden sides important to the design.

Do not present weakly observed hidden geometry as exact.

## 2. Establish scale

Best sources:
1. user-provided exact dimension;
2. known standard object dimension;
3. multiple measurable views;
4. estimated scale only when no better source exists.

Mark estimated scale explicitly.

## 3. Calibrate viewpoint

For perspective references:
- estimate focal-length class;
- match camera elevation and azimuth;
- match subject framing;
- compare silhouette from the reference camera.

Do not distort geometry to compensate for a mismatched camera.

## 4. Decompose the object

Identify:
- primary volumes;
- symmetry;
- repeated elements;
- negative spaces;
- joints;
- likely moving pieces;
- surface detail;
- materials.

Build primary masses first.

## 5. Choose construction method

Rigid manufactured object:
- hard-surface primitives/booleans/modifiers.

Organic object:
- sculpt/blockout, then retopo if animation needs it.

Mixed object:
- separate rigid and organic regions.

Repeated structures:
- Geometry Nodes/Array.

## 6. Plan for animation early

If the user may animate the object:
- keep moving parts separate;
- place seams at real joints;
- preserve pivots;
- do not fuse mechanical pieces unnecessarily.

For organic deformation:
- plan topology before fine detail.

## 7. Reference gates

At minimum compare:
- silhouette;
- height/width ratio;
- major landmark coordinates;
- spacing of repeated features;
- joint locations.

Render from the matched reference camera and compare again after each major modeling phase.

## 8. Hidden geometry

For unseen sides:
- exploit symmetry only when justified;
- infer construction logically;
- keep uncertain details simple;
- prefer reversible modeling decisions.

If missing information materially affects function or recognizability, ask for another view when practical.

## Completion

A model is not "matched" because it looks generally similar.
Pass only when the chosen reference gates are satisfied.
