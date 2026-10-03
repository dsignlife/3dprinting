---
name: blender-task-router
description: Choose the correct Blender workflow before execution: image reconstruction, hard-surface, sculpting, retopology, rigid animation, armature rigging, shape keys, drivers, physics, Geometry Nodes, print preparation and QA.
---

# Blender Task Router

Use this skill first for broad or ambiguous Blender requests.

## Goal

Choose the smallest reliable workflow that satisfies the request.
Do not start building until the task has been classified.

## 1. Classify the input

### Existing 3D model
Inspect:
- format;
- hierarchy;
- separate moving parts;
- existing armature;
- existing Actions/NLA;
- transforms/origins;
- topology;
- materials.

Prefer modifying the existing asset over rebuilding it.

### Single image
Treat hidden geometry and true depth as uncertain.
Use silhouette, visible proportions and known dimensions.
Explicitly mark inferred regions.

### Multiple images
Determine whether each image is:
- orthographic/turnaround;
- perspective photo;
- detail callout.

Use orthographic references for measurable proportions when trustworthy.
Use perspective images primarily for silhouette/detail unless camera calibration is available.

### Pure text
Choose forms and dimensions from the request, and state assumptions.

## 2. Classify the geometry

Use:
- `blender-hard-surface` for manufactured/rigid forms;
- `blender-sculpting-organic` for organic freeform shapes;
- `blender-geometry-nodes` for repeated/procedural systems;
- `blender-topology-retopology` when an existing/sculpted mesh must deform cleanly;
- `blender-modeling-core` for general construction.

Hybrid assets may use more than one.

## 3. Classify motion

Choose one primary motion system:

### Object transforms
For one rigid object moving/rotating/scaling.

### Parent hierarchy
For articulated rigid assemblies with obvious pivots.

### Armature
For:
- characters;
- creatures;
- flexible deformation;
- multi-joint control;
- robotic chains benefiting from IK.

### Shape keys
For:
- facial expressions;
- morphs;
- localized surface deformation;
- corrective poses.

### Drivers
For deterministic relationships:
- gear ratios;
- pistons;
- linked controls;
- parameter-driven motion.

### Physics
Use only when the motion should emerge from simulation:
- rigid-body impacts;
- cloth;
- soft-body;
- fluid;
- secondary physical motion.

Do not use physics when deterministic keyframes are simpler and more controllable.

## 4. Decide whether rigging is needed

Do not create an armature merely because the user says "animate."

Examples:
- spinning propeller -> object rotation;
- hinged door -> origin + rotation constraint/keyframes;
- robotic arm -> parent hierarchy or armature/IK;
- human -> armature + weights;
- changing facial expression -> shape keys or bones;
- falling debris -> rigid body physics.

## 5. Decide topology needs

If the object is rigid:
- clean manifold topology matters;
- perfect deformation loops are unnecessary.

If the object deforms:
- edge flow around joints matters;
- retopology may be required before rigging.

If the object will be 3D printed:
- watertightness, wall thickness, dimensions and clearances outrank animation topology.

## 6. Define acceptance gates before execution

Choose relevant gates:
- reference silhouette match;
- measured proportions;
- clean articulation;
- no visible intersections;
- loop continuity;
- correct dimensions;
- manifold/watertight geometry;
- exported artifact re-import;
- print validation.

## Output

Before a broad task, internally produce:

- input type;
- modeling strategy;
- topology strategy;
- animation strategy;
- validation strategy;
- relevant skills to load.

Then execute.
