# Blender 3D Studio agent guide

## Role and execution

Execute supplied Blender plans without repeated reference analysis, redesign, or extra artistic passes. Preserve unmentioned parts. For open briefs, choose relevant workflows and state assumptions.

Use configured MCP server `blender`; Blender is remote. Docker, networking, and configuration are user-managed. Do not manage infrastructure unless requested. On connection failure, report the exact error and stop.

Check required status/version; inspect necessary scene details once. Plan before executing and batch related edits; split large workloads into bounded stages. Do not create helper execution files. Keep narration brief.

## Safe mode

Treat `execute_blender_code` as an AST allowlist, not unrestricted Python. Review the entire payload before sending; blocked code in unused functions or branches still fails. Never disable or bypass validation.

- Prefer explicit `import bpy`, `import bmesh`, `import math`, `import mathutils`. No module aliases, `from bpy import ...`, wildcard/relative imports, or unverified modules. `os`, `sys`, `pathlib`, `subprocess`, `socket`, `requests`, `urllib`, `numpy`, and `ctypes` are blocked.
- Use direct datablock edits, modifiers, materials, constraints, shape keys, and keyframes. Keep module namespaces in explicit dotted paths; never alias/pass `bpy`, `bpy.ops`, or `bpy.ops.wm`. Do not alias callables or shadow modules/builtins, including function parameters named `type`, `object`, `id`, or `list`.
- No `open()`, `eval`, `exec`, `compile`, dynamic imports, introspection escapes, or dunder access. Attribute helpers such as `getattr` require literal names; prefer direct attributes.
- No lambdas, decorators, classes, async/yield, walrus, `match`, `global`, or `nonlocal`. Use ordinary `def`, loops, and explicit call targets.
- No handlers, timers, drivers/expressions, registration, script/text/console/add-on operators, external blend datablock linking/appending, startup/preferences changes, or process/network access.
- Prefer an exposed dedicated tool when it fits. Before operators, establish active object, selection, mode, and required camera; check `poll()`. Use API/node schemas for uncertain types, ranges, enums, or sockets. Context errors are distinct from AST rejection.
- Keep code and geometry bounded; split only when workload requires it. Do not invent universal limits. After timeout, inspect existing changes before retrying to avoid duplicates.
- Raw filesystem I/O is blocked; requested Blender-native saves/imports/exports are not categorically forbidden. Follow actual tool policy and delivery requirements.

For detailed verified syntax rules and payload limits, read [tools/README.md#safe-mode-preflight](tools/README.md#safe-mode-preflight) before unfamiliar constructs. Correct a rejection once using its exact reason; retry once, then report the blocker.

## Poly Haven assets

Poly Haven CC0 HDRIs, textures, and models may be searched, downloaded, and applied when relevant without additional approval. Check integration status; use exposed MCP tools rather than network/file code in Blender Python. Preserve source metadata and protected scene content. See [workflow](tools/README.md#poly-haven).

## Deliverables and boundaries

After each completed Blender implementation, capture the result with `get_viewport_screenshot` and save its returned image locally as `outputs/<task-id>/result.png`. Use a requested filename or a revision suffix to preserve existing pictures. Verify the image is readable and link it in the final reply. A remote path or chat image alone is not local delivery. Save other sources/exports and perform broader checks when requested. Follow [the capture workflow](tools/README.md#result-picture). Report capture/save failures after one corrected retry; never claim the picture was saved without a verified file.

Preserve originals. Ask before purchases, paid services, publication, or physical printer actions. Print preparation does not authorize printing.

## Supporting context

Read relevant [project](README.md), [role](roles/README.md), [output](outputs/README.md), [evaluation](evals/README.md), and matching skill guidance; [CLAUDE.md](CLAUDE.md) is the optional adapter.

Follow [memory guidance](memory/README.md): one `memory/shorterm/` note for longer tasks, confirmed decisions in `longterm/`, verified lessons in `learnings/`. Keep references in knowledge, procedures in skills, utilities in tools. Delegate only when requested or required. Keep credentials/traces out of Git. Edit instructions only on request; stay under 600 words. Complete authorized scope and report results/blockers.
