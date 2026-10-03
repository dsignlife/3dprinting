---
name: blender-object-animation
description: Animate rigid Blender objects and cameras using keyframes, F-curves, interpolation, constraints, drivers, Actions and NLA.
---

# Blender Object Animation

Define FPS, frame range, loop requirement, moving objects, pivots and motion stages before keyframing.

## Workflow
1. Verify origins/pivots.
2. Set frame range/FPS.
3. Insert minimal key poses.
4. Inspect F-curves.
5. Choose interpolation deliberately.
6. Add breakdowns only when needed.
7. Preview the entire range.
8. Fix pops, overshoot and discontinuities.
9. Bake only when necessary.

## Interpolation
- BEZIER: natural acceleration/deceleration.
- LINEAR: constant mechanical motion.
- CONSTANT: stepped motion.

For wheels/propellers, prefer linear interpolation and clean loop behavior.

## F-curves
Watch for:
- unwanted keys;
- Euler flips;
- overshoot;
- bad handles;
- loop discontinuities.

Use quaternion rotation when Euler gimbal issues matter.

## Actions/NLA
Use Actions for reusable clips.
Use NLA for repeating, sequencing or layering clips.
