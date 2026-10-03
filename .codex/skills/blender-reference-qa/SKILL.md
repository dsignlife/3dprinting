---
name: blender-reference-qa
description: Review Blender work against source images using matched cameras, silhouette/proportion comparisons, landmark measurements and explicit pass/fail gates rather than subjective visual approval.
---

# Blender Reference QA

Use after blockout and again before final approval.

## Compare from the same viewpoint

Match:
- camera angle;
- focal length class;
- framing;
- object scale in frame.

A different camera can make correct geometry look wrong and wrong geometry look correct.

## Gates

### Silhouette
Primary outline should match high-confidence reference.

### Proportions
Compare ratios:
- total height/width/depth;
- major section lengths;
- spacing.

### Landmarks
Measure important visible landmarks.

### Negative space
Check holes, gaps, wheel arches, limbs, handles and openings.

### Articulation
For animated assets verify joint centers are visually and mechanically plausible.

## Iteration

If a gate fails:
- identify whether error comes from geometry, camera or scale;
- fix the source cause;
- re-render/re-measure.

Do not accept "close enough" before checking the defined high-value landmarks.
