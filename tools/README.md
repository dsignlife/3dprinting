# Blender tools and capabilities

Use the configured `blender` MCP server for Blender work. Blender runs on another computer. The user handles Docker, container lifecycle, dependencies, network access, and MCP configuration manually. The agent does not manage or diagnose that infrastructure unless separately requested.

## Available tool surface

Observed during initialization on 2026-10-05:

| Capability | Evidence and limitation |
| --- | --- |
| Blender MCP | Status, scene, code execution, screenshot, and export tools exposed; the initialization status call failed to connect to Blender |
| Bambu MCP | Printer, file, slicing, and mesh tools exposed; connectivity and operations were not tested |
| Optional asset integrations | Library and generator tools exposed; authentication, availability, and paid usage were not tested |
| Skills | Blender manifests exist in [.codex/skills/](../.codex/skills/); read only the matching procedure |
| Shared utilities here | Documentation only |

These are dated observations, not a permanent health guarantee. The Blender status call reported: "Could not connect to Blender. Make sure the Blender addon is running." If a task encounters a connection failure, report it exactly and stop Blender execution so the user can resolve it manually. Do not launch another server or attempt infrastructure workarounds.

## Plan-led execution

Treat a supplied correction plan as the source of truth. Make required version/status checks and only necessary scene inspection, then apply related edits in one primary code batch when practical. Do not repeat image analysis or perform automatic artistic refinement passes.

Use safe-mode-compatible direct Blender APIs as described in [AGENTS.md](../AGENTS.md). Do not create helper execution files merely to carry out an edit. Correct a technical failure once and retry once; report any remaining blocker.

Capture and save one result picture after every completed Blender implementation using the workflow below. Additional renders and broader validation follow the request. Saving a remote file is not proof of local delivery; use supported MCP transport and report actual locations. Avoid custom transfer workarounds.

Optional services need task relevance and availability checks; purchases and paid services need approval. For a requested printer workflow, read [bambu-p2s-mcp-executor](../.codex/skills/bambu-p2s-mcp-executor/SKILL.md). Physical printer actions require explicit approval.

Configuration files remain user-managed. Keep private configuration values and credentials out of reports. No infrastructure changes are part of ordinary Blender execution.

## Result picture

Every completed Blender implementation includes a local picture of its final result:

1. Frame the implemented object or scene clearly in the final viewport, preserving the user's intended view when supplied. Do not add an artistic correction pass merely to capture the picture.
2. Call `get_viewport_screenshot`. Use the returned image bytes or an accessible image resource through supported MCP transport. A path on the Blender computer is not a local result file.
3. Create `outputs/<task-id>/` on this computer and save the PNG as `result.png`, or use the filename specified in the brief. If a picture already exists, preserve it and use the next revision suffix, such as `result-02.png`.
4. Write/decode the returned image using local filesystem tools, outside `execute_blender_code`. Do not put local filesystem, network, or transfer code into the safe-mode Blender payload; do not create custom helper files or shared-folder workarounds.
5. Verify the local file exists, is nonempty, and decodes as an image. Link it in the final reply. An image displayed in chat alone does not satisfy this requirement.

For capture or save failure, make at most one corrected retry. Report the exact failure and distinguish successful Blender edits from incomplete picture delivery. Do not claim completion of the picture deliverable until a readable local file is verified. Docker and infrastructure remain user-managed.

## Safe mode preflight

This guidance was checked against `src/blender_mcp/safe_mode.py` and the transport code inside the repository's [packaged MCP source](../mcp-for-blender-fix-screenshot-over-socket.zip) on 2026-10-05. The [upstream validator](https://github.com/ahujasid/mcp-for-blender/blob/main/src/blender_mcp/safe_mode.py) is a supporting reference. The running container was not inspected; policy can change with versions. This inspection did not change Docker or connect to Blender.

Before sending code, check imports, bindings, syntax, calls, Blender paths, operator context, and workload. The validator checks the whole AST, including unreachable code. Removing an invocation while leaving a forbidden import or function in the payload does not fix rejection.

### Imports, names, and calls

- Use unaliased module imports. `import bpy as b` is rejected. Every `from bpy import ...` is rejected. Explicit `from mathutils import Vector` is permitted by the packaged policy; wildcard, relative, and private-name imports are not.
- Prefer the core modules named in [AGENTS.md](../AGENTS.md). Additional modules must be on the actual allowlist. Blender bundling a module does not permit importing it; `numpy`, `os`, `sys`, `pathlib`, `subprocess`, `socket`, `requests`, `urllib`, `pickle`, `marshal`, and `ctypes` are absent.
- Do not shadow imported modules or builtins in assignments, loop variables, function names, or parameters. Use names such as `object_kind`, `mesh_object`, and `asset_id` rather than `type`, `object`, or `id`.
- Do not store module namespaces or callables for later invocation: `ops = bpy.ops` and `create = bpy.ops.mesh.primitive_cube_add; create()` fail. Use full dotted call paths; ordinary object/datablock variables remain usable.
- Avoid `globals`, `locals`, `vars`, `dir`, `help`, `super`, and interpreter escape builtins. Attribute helpers require literal strings, such as `getattr(obj, "location")`; variable names, concatenated strings, and namespace lookup are rejected.
- Ordinary named functions and loops are supported. Lambdas, decorators, class definitions, generators using `yield`, async constructs, walrus expressions, pattern matching, and global/nonlocal declarations are rejected.

### Blender API and context

Do not access script/text/library datablocks, handlers, timers, drivers, driver namespaces, registered properties, or code-executing operator namespaces. Do not enable script auto-execution, install add-ons, change startup settings, append/link external blend datablocks, or launch external players/processes.

Prefer direct data APIs over context-sensitive operators. When an operator is necessary, establish the relevant mode, active object, selection, and view-layer context, then check its `poll()`. A render needs a valid scene camera. Inspect required parameters and enum values with `bpy_api_lookup`; inspect node sockets with `describe_node_type` when uncertain. Do not invent tool names or pass guessed types, ranges, enums, or localized node names.

An AST pass does not guarantee the operation will succeed in Blender. Separate policy rejection, tool-schema errors, and Blender context/API failures when choosing a correction.

### Files, size, and retries

Raw Python filesystem/network access is blocked. The packaged validator permits rendering, Blender-native image loading, saves, and import/export operations; these still require requested scope and suitable paths. Use an exposed export or screenshot tool when it fits. A remote save is not proof of local delivery.

The packaged validator caps code at 200,000 UTF-8 bytes, 20,000 AST nodes, and nesting depth 24. Its transport uses a 180-second socket timeout. These are source-version details, not universal MCP guarantees or workload targets. Keep practical payloads smaller, bound geometry counts and loops, and split expensive work into meaningful sequential stages when necessary. Keep related small edits batched.

Never weaken safe mode, obfuscate calls, or route around it. On AST rejection, remove the rejected construct everywhere, review the whole payload, and retry once. On runtime failure or timeout, inspect whether earlier edits took effect before any corrected retry; avoid duplicate objects or repeated destructive edits. If connection fails, report it and stop for the user to resolve manually.
