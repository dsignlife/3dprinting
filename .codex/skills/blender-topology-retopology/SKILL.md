---
name: blender-topology-retopology
description: Decide when and how to retopologize Blender meshes for deformation, clean subdivision, animation and robust downstream use while preserving silhouette and important features.
---

# Blender Topology & Retopology

Use when topology quality affects deformation or editing.

## Retopology is usually needed when

- an organic sculpt will be rigged;
- AI/imported geometry is chaotic;
- joints collapse during deformation;
- subdivision produces artifacts;
- animation-ready edge flow is requested.

It may be unnecessary for a static rigid print if the mesh is already manifold and dimensionally correct.

## Deformation topology

Prioritize loops around:
- shoulders;
- elbows;
- wrists;
- hips;
- knees;
- ankles;
- mouth;
- eyes;
- other bending regions.

Provide enough geometry for bending without unnecessary density.

## Hard-surface topology

Preserve:
- clean silhouette;
- predictable bevels;
- clean shading;
- modifier stability.

## Retopo gate

Before rigging:
- test simple bends;
- inspect silhouette;
- inspect volume preservation;
- fix pinching/collapse.

Do not proceed to detailed weight painting when base topology is clearly unsuitable.
