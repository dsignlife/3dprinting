---
name: blender-animation-strategy
description: Choose the right Blender animation architecture—object keyframes, hierarchy, armature, IK/FK, constraints, drivers, shape keys, NLA or physics—based on the requested motion and asset structure.
---

# Blender Animation Strategy

Use before complex animation.

## 1. Translate request into motion

Identify:
- what moves;
- what stays rigid;
- what deforms;
- motion axes;
- pivots;
- contacts;
- loop requirement;
- duration/FPS;
- whether motion must be deterministic.

## 2. Select mechanism

### Direct object keyframes
One/few rigid parts.

### Parent hierarchy
Mechanical assemblies.

### Armature
Organic deformation or complex articulated chains.

### IK
Endpoint-driven tasks:
- hand reaches;
- foot plants;
- robotic end-effector.

### FK
Free arcs and direct joint control.

### Constraints
Use for:
- limits;
- tracking;
- parent-like relations;
- path following;
- maintaining mechanical relationships.

### Drivers
Use for mathematical linkage.

### Shape keys
Use for morphs and surface-local changes.

### NLA
Use for reusable/sequenced/layered Actions.

### Physics
Only when simulation is the intended behavior.

## 3. Choose rotation representation

Euler:
- simple limited-axis mechanical movement.

Quaternion:
- large compound rotation or gimbal-risk situations.

## 4. Keyframe economy

Prefer strong key poses and intentional interpolation over dense uncontrolled keys.

## 5. Validate

Check:
- pivots;
- contacts;
- intersections;
- continuity;
- F-curves;
- loop boundary;
- parent/constraint side effects.

Choose the simplest architecture that remains editable.
