# AGENTS.md

## Purpose

Use Codex as the Blender executor, not the visual art director.

Image/reference analysis and the detailed improvement plan will usually be prepared before Codex is asked to edit Blender.

Codex should take that plan, inspect only what is necessary in the live scene, convert the plan into Blender code, apply the changes in a batch, and stop.

Optimize for:
- low token use;
- few MCP calls;
- batched Blender edits;
- no repeated visual-analysis loops;
- safe-mode-compatible code on the first attempt.

---

## Blender MCP

Use the configured Codex MCP server named `blender` for all Blender work.

The server is already configured in `.codex/config.toml`.

Do not:
- search for `BLENDER_MCP_COMMAND`;
- search for `BLENDER_MCP_ARGS`;
- launch another Blender MCP server;
- assume Blender is running locally.

Blender runs on another computer and is reached through the configured MCP server.

If the Blender MCP connection fails, report the exact connection failure and stop.

---

## Safe mode

`BLENDER_MCP_SAFE_MODE=1` is enabled.

All Blender Python must be safe-mode-compatible before the first MCP call.

Prefer:
- `bpy`
- `bmesh`
- `math`
- `mathutils`
- direct object/mesh/datablock edits
- modifiers
- materials/shader nodes
- armatures
- constraints
- shape keys
- direct keyframes
- camera/light/render settings

Do not send Blender Python that uses:
- `open()`
- `os`
- `pathlib`
- `subprocess`
- shell/process launching
- sockets/networking
- `requests`
- `urllib`
- `eval`
- `exec`
- `compile`
- dynamic imports
- `pickle`
- `marshal`
- `ctypes`
- handlers
- timers
- drivers
- class/property/add-on registration
- external `.blend` datablock loading
- dynamically generated Python code

Do not probe blocked methods first.

If the intended implementation is not safe-mode-compatible, choose a Blender-native alternative before making the MCP call.

If safe mode rejects a call:
1. read the rejection;
2. remove the blocked construct;
3. rewrite with direct Blender APIs;
4. retry once.

Do not enter a workaround loop.

---

## Source of truth

When the user provides a detailed correction or implementation plan, treat that plan as the source of truth.

Do not re-analyze the reference image, redesign the task, or invent additional improvements unless the user explicitly asks.

Do not spend Codex credit independently critiquing the model when the requested changes are already specified.

Preserve parts that are not mentioned unless a requested change requires touching them.

---

## Default execution workflow

For a normal Blender improvement request:

1. Read the requested correction plan.
2. Inspect the live scene once only if object names, hierarchy, materials, transforms, or topology must be discovered.
3. Plan the complete Blender implementation before executing.
4. Apply all related requested changes in one primary `execute_blender_code` batch whenever practical.
5. Stop and report what changed.

Default budget:
- maximum 1 inspection call;
- maximum 1 primary Blender code call.

A second Blender code call is allowed only when:
- the first call failed technically; or
- the user explicitly requests another correction pass.

Do not automatically perform a second artistic refinement pass.

---

## Batch execution

Think before executing, not between every small edit.

Good:

`inspect once -> plan complete pass -> execute complete pass -> stop`

Bad:

`edit one part -> inspect -> edit another part -> screenshot -> analyze -> repeat`

Batch related changes together, including when appropriate:
- silhouette/proportions;
- pose;
- face;
- hair;
- hands;
- clothing;
- accessories;
- materials/colors;
- camera/lighting.

Do not make one MCP call per body part, material, modifier, or parameter.

The Blender MCP code payload itself should be the implementation.

Do not create helper `.py`, `.ps1`, `.sh`, `.bat`, or `.cmd` files merely to perform the Blender edit.

---

## Visual-reference priorities

When a correction plan is based on a reference image, preserve this priority order:

1. silhouette
2. proportions
3. pose
4. camera/perspective
5. face and focal features
6. major clothing/accessory shapes
7. major colors
8. material response
9. secondary detail
10. micro-detail

Do not spend time on tiny detail while major form or pose corrections are still requested.

For a single image, optimize the requested hero view first. Hidden geometry may be reasonably inferred.

---

## Screenshots

Do not take screenshots automatically for self-review.

Use `get_viewport_screenshot` only when:
- the user explicitly asks for a preview/current screenshot;
- the prompt explicitly requests visual verification; or
- a screenshot is the requested deliverable.

The screenshot transport can return PNG image data through MCP.

When a local preview file is requested:
1. call `get_viewport_screenshot`;
2. receive the returned image data;
3. save/decode it locally on Computer 1;
4. write it under `output/`.

Use names such as:
- `output/<project-name>-current.png`
- `output/<project-name>-final.png`

Do not:
- save screenshots to a Computer 2 path and call that the deliverable;
- create SMB/shared-folder workarounds;
- use Docker temp-path screenshot workflows;
- create custom image-transfer scripts;
- repeatedly retry the same screenshot failure.

If screenshot capture fails, report the exact error after at most one corrected retry.

---

## Saving Blender files

Do not save `.blend`, `.glb`, `.stl`, or other files unless the user explicitly requests that deliverable.

Do not save a `.blend` file on Computer 2 merely because the Blender task is finished.

A remote Computer 2 path is not a substitute for a requested local preview or deliverable.

---

## Validation

Do not automatically run broad QA, topology audits, render-statistics checks, exposure analysis, repeated camera measurements, or independent mesh validation.

Validate only what the prompt explicitly requires.

If the user asks only for a visual improvement batch, successful Blender execution is enough. Let the user decide whether another visual pass is needed.

---

## Communication

Keep narration minimal.

Before tool use, do not write a long plan unless the user asks for one.

After execution, report only:
- what was changed;
- whether the Blender call succeeded;
- any concrete blocker or limitation.

Do not narrate every edit, every parameter choice, or internal reasoning step.

---

## Failure policy

Only stop early for a real blocker:
- Blender MCP unreachable;
- required object/asset unavailable;
- destructive ambiguity about which user work to modify;
- requested operation cannot be done safely under safe mode.

For a normal technical failure:
1. diagnose once;
2. correct once;
3. retry once;
4. if it still fails, stop and report the blocker.

Never loop indefinitely.
