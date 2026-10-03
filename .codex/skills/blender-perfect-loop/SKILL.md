---
name: blender-perfect-loop
description: Create seamless looping Blender animation for rotating objects, mechanical cycles, turntables and repeating Actions.
---

# Blender Perfect Loop

A loop must match at its boundary in value and motion.

## Rotation loops
For a full rotation:
- animate from starting angle to exactly one full revolution;
- use LINEAR interpolation for constant speed;
- avoid rendering both duplicate boundary frames when playback/export semantics would cause a pause.

## Repeated Actions
Use cycle modifiers or NLA repetition where appropriate.

## Mechanical loops
Check all linked parts return to the same state at the loop boundary:
- transform;
- constraint state;
- driver state;
- shape key values.

## Validation
Scrub across the last-to-first frame boundary.
Check no position, velocity or pose discontinuity is visible.
