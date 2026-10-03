---
name: blender-reference-to-3d
description: Reconstruct Blender objects from screenshots/photos/concept art using silhouette analysis, proportion matching, multiple-view alignment and explicit assumptions for hidden geometry.
---

# Reference Image to 3D

Analyze:
- silhouette;
- major proportions;
- symmetry;
- repeated features;
- likely primitive decomposition;
- visible joints/pivots;
- material boundaries;
- hidden/uncertain regions.

A single image does not reveal exact depth or hidden geometry.
State assumptions instead of pretending unseen dimensions are known.

## Workflow
1. Establish scale reference.
2. Block primary forms.
3. Match silhouette from reference angle.
4. Establish depth.
5. Add secondary forms.
6. Separate parts that may animate.
7. Add bevel/material detail last.
8. Compare a Blender camera view against the reference and iterate.

For multiple views, align them to a common scale and resolve inconsistencies before fine detail.
