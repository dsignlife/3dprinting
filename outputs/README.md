# Blender deliverables

Save a result picture after every completed Blender implementation under `outputs/<task-id>/`, using a descriptive identifier such as `desk-organizer`. Additional source files and exports follow the task brief. Preserve original assets and existing pictures; use a revision suffix for later results.

Example layout; `result.png` is the default implementation deliverable, and other files are created when requested:

```text
outputs/<task-id>/
  <asset>.blend
  result.png
  <asset>.glb
  <asset>.stl
  validation.md
```

## Formats and checks

- `.blend`: editable source; document scene organization and linked resources when needed.
- `result.png`: final viewport picture saved locally after implementation; use a requested filename or the next revision suffix when needed. Check that it exists, is nonempty, and decodes as an image, then link it in the final reply. See [the capture workflow](../tools/README.md#result-picture).
- `.glb`/`.gltf`: requested web or interchange export; preserve required materials and animation.
- `.stl`/`.3mf`: requested print export; state units and dimensions and whether a 3MF is a model project or contains sliced print instructions.
- Animation, viewer, or other exports: use the format, naming, and settings from the brief.

Perform the checks requested in the brief. For requested print validation, review manifold geometry, normals, bodies, wall thickness, clearances, dimensions, and orientation. Report completed and unavailable checks without implying unperformed verification. Create `validation.md` when a report is requested; link evidence instead of copying raw logs.

Blender runs on another computer. A remote save path is not a local deliverable: use supported MCP transport when local delivery is requested, and report where the artifact actually exists. Do not add shared-folder or custom transfer workarounds.

Keep live task state in [short-term memory](../memory/shorterm/README.md). Deliverables belong here; procedures and utilities belong in their own locations.

## Git and sharing

The current `.gitignore` excludes singular `output/*`, not this `outputs/` directory. Review changes before staging; intentionally version only artifacts needed by the project. Keep large generated binaries, caches, traces, and credentials out of commits unless artifact versioning is explicitly intended. Configure ignore rules separately when needed; initialization does not change them.

Local saving does not authorize publication, paid rendering, or physical printing. Follow [AGENTS.md](../AGENTS.md). No scene, render, or export was produced during documentation initialization.
