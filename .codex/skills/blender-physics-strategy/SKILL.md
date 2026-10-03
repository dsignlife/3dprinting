---
name: blender-physics-strategy
description: Decide when Blender physics should replace or augment keyframed animation, selecting rigid bodies, cloth, soft bodies, fluids, force fields and baking only when simulation adds real value.
---

# Blender Physics Strategy

Physics is not the default animation solution.

## Use rigid bodies for
- collisions;
- falling objects;
- debris;
- physically reacting rigid pieces.

## Use cloth for
- fabric;
- flags;
- capes;
- flexible sheets.

## Use soft body for
- deformable springy masses.

## Use fluid when
- actual liquid/smoke behavior is central.

## Do not use simulation when
- exact repeatable motion is required;
- a hinge/driver/keyframe solves the task more simply;
- the result must be easy to edit deterministically.

## Workflow
1. establish scale;
2. simplify collision geometry;
3. define static/active bodies;
4. set constraints/forces;
5. test low-cost simulation;
6. tune;
7. bake only after behavior is accepted.

## Export/printing note

Simulation is animation behavior, not printable mechanism design.
If the final goal is a physical moving print, model actual joints/clearances separately.
