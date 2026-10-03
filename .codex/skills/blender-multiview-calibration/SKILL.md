---
name: blender-multiview-calibration
description: Align multiple reference images in Blender for consistent reconstruction: common scale, ground line, orthographic vs perspective classification, camera matching and cross-view landmark validation.
---

# Blender Multi-View Calibration

Use when two or more images show the same object.

## Workflow

1. Identify view type for every image:
   - front;
   - side;
   - back;
   - top;
   - three-quarter;
   - detail;
   - perspective photo.

2. Choose the master scale source.

3. For orthographic/model-sheet views:
   - align common ground line;
   - normalize object height;
   - verify shared landmarks.

4. For perspective photos:
   - do not force them into orthographic measurement;
   - estimate camera;
   - use them for silhouette and depth evidence.

5. Track common landmarks:
   - joint centers;
   - wheel centers;
   - corners;
   - openings;
   - eyes/shoulders/hips for characters.

6. Resolve conflicts explicitly:
   - measurement/reference sheet wins for proportion;
   - detail image wins for surface appearance;
   - user-stated dimensions win over visual estimation.

## Gate

Before fine modeling, ensure the blockout agrees with all high-confidence views.
