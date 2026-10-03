---
name: blender-mechanical-animation
description: Animate mechanical assemblies: hinges, propellers, wheels, gears, pistons, sliders, robotic arms, doors and linkages with correct pivots, limits and drivers.
---

# Blender Mechanical Animation

For each moving part identify:
- pivot location;
- pivot axis;
- motion limits;
- parent/reference frame;
- keyed vs constrained vs driven motion.

## Patterns

### Hinge
Origin on hinge axis; animate one rotation channel; optionally Limit Rotation.

### Propeller / wheel
Origin centered on shaft; one-axis rotation; LINEAR interpolation; seamless cycle.

### Piston
Constrain translation to one axis; use driver/constraint when tied to crank rotation.

### Gear pair
Use opposite directions for external gears.
Drive angular ratio from tooth count/radius rather than manually matching keys.

### Robotic arm
Parent base-to-tip.
Set joint axes/limits.
Use armature + IK if endpoint control is useful.
Rigid segments should not deform.

### Slider / door
Animate one local axis and clamp range.

## Validation
Scrub timeline for intersections, drifting pivots, broken limits, loop jumps and parent-induced scale/rotation.
