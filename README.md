# Blender 3D Studio

A Codex project for creating and refining Blender scenes, 3D assets, and printable models from briefs and reference images.

The primary agent executes requested modeling, materials, lighting, cameras, animation, rendering, and export work through Blender MCP. When supplied a correction plan, it follows that plan in a batch without repeating visual analysis or adding artistic refinement passes. It selects relevant skills and performs requested checks. See [AGENTS.md](AGENTS.md) for shared instructions and [roles/README.md](roles/README.md) for responsibilities.

## Scope and boundaries

Work stays within the requested scenes, assets, and repository scope. Preserve original source assets and save revisions separately. Ask before purchasing assets, starting paid services, publishing work, or performing physical printer actions. A modeling request does not authorize printing.

After every completed Blender implementation, save a result picture locally as `outputs/<task-id>/result.png` and link it in the final reply. Save additional Blender files and exports when requested. See [outputs/README.md](outputs/README.md).

Poly Haven CC0 HDRIs, textures, and models are authorized when they help the requested scene. Use the configured MCP integration and preserve asset provenance; see [the workflow](tools/README.md#poly-haven). Paid services still need approval.

## Connection and infrastructure ownership

Blender runs on another computer and is accessed through the configured Codex MCP server named `blender`. The user manages Docker, containers, dependencies, networking, and MCP configuration manually. Start Codex at this repository root with those connections already prepared. The agent does not provision or diagnose infrastructure unless separately requested.

Blender and Bambu MCP tools were exposed during initialization on 2026-10-05. The Blender status call returned: "Could not connect to Blender. Make sure the Blender addon is running." This is a dated observation; connection health must be established when needed for actual work. If Blender is unreachable, the agent reports the exact error and stops Blender execution for the user to resolve.

Printer connectivity, optional asset services, rendering, export transport, and mesh validation runtimes were not verified during initialization. See [tools/README.md](tools/README.md) for capabilities and limitations.

OpenClaude is an optional alternative runner, not configured or tested by initialization; [CLAUDE.md](CLAUDE.md) remains its shared-instruction adapter.

## Working on a 3D task

Give the agent the intended use, input assets or references, dimensions when known, desired appearance or motion, and deliverables. State critical fit dimensions and whether the asset must be printable, deform for animation, or run on the web.

For a supplied implementation plan, the agent discovers only necessary scene details, plans the complete pass, and batches related edits in one primary Blender code call when practical. It preserves unmentioned parts and avoids repeated visual-analysis loops. For an open brief, it chooses the relevant workflow and states necessary assumptions.

One saved result picture is included automatically after implementation. Additional sources, exports, renders, and broader quality checks follow the task brief. Capture the final viewport without adding an artistic refinement pass. A technical failure gets one corrected retry; a connection failure is reported for manual resolution. Report what changed, whether execution succeeded, the local picture link, and concrete limitations.

Examples:

```text
Create a matte black desk organizer in Blender, 160 x 80 x 50 mm.
Save the .blend and a preview under outputs/desk-organizer/. Prepare
an STL and check manifold geometry, wall thickness, clearances,
and print orientation. Do not start a print.
```

```text
Refine my supplied GLB with glossy materials and studio lighting.
Preserve the source. Save the .blend and a PNG preview under
outputs/product-shot/. Verify materials, scale, and framing.
```

```text
Reconstruct this object from the reference images and supplied
dimensions. Identify inferred hidden geometry and compare the result
with the references before exporting a GLB under outputs/reference-model/.
```

## Skills and context

Read only relevant skills and supporting files. Existing manifests live in [.codex/skills/](.codex/skills/); their presence does not prove an integration is connected.

| Task | Starting skills |
| --- | --- |
| Broad Blender task | [blender-task-router](.codex/skills/blender-task-router/SKILL.md) |
| General or manufactured geometry | [blender-modeling-core](.codex/skills/blender-modeling-core/SKILL.md), [blender-hard-surface](.codex/skills/blender-hard-surface/SKILL.md) |
| Reference reconstruction | [blender-image-to-3d-director](.codex/skills/blender-image-to-3d-director/SKILL.md), [blender-reference-to-3d](.codex/skills/blender-reference-to-3d/SKILL.md), [blender-reference-qa](.codex/skills/blender-reference-qa/SKILL.md) |
| Materials and presentation | [blender-materials](.codex/skills/blender-materials/SKILL.md), [blender-product-polish](.codex/skills/blender-product-polish/SKILL.md) |
| Animation | [blender-animation-strategy](.codex/skills/blender-animation-strategy/SKILL.md), then the matching motion or rigging skill |
| Printable models | [blender-printability-director](.codex/skills/blender-printability-director/SKILL.md), [blender-print-prep](.codex/skills/blender-print-prep/SKILL.md), [mesh-print-validation](.codex/skills/mesh-print-validation/SKILL.md) |
| Scene review and web export | [blender-qa-review](.codex/skills/blender-qa-review/SKILL.md), [blender-threejs-export](.codex/skills/threejs-export/SKILL.md) |
| Requested printer workflow | [bambu-p2s-mcp-executor](.codex/skills/bambu-p2s-mcp-executor/SKILL.md) |

Keep domain references in `knowledge/` when needed; that folder is not currently present. Keep procedures in skills, shared executable utilities in `tools/`, and context in [memory/](memory/README.md). Preserve existing source content in `backlog/`.

## Requested quality checks

Validate the brief's acceptance criteria. Do not automatically add broad QA, topology audits, render analysis, or independent mesh validation to a correction batch. Successful Blender execution is evidence that the edit ran; it is not proof of checks that were never performed.

When requested, inspect a preview, measure dimensions and scale, verify export settings, compare references, or review animation. For requested print validation, check manifold geometry, normals, disconnected bodies, wall thickness, clearances, and orientation. Report checks as passed, failed, or unverified with evidence. See [evals/README.md](evals/README.md).

## Initialize or update project setup

This repository is initialized for the brief above. When adapting a copy or changing the role:

1. Start the chosen runner at the project root.
2. Supply the project brief using the prompt below.
3. Review documentation changes. The user resolves infrastructure blockers manually before dependent work.

### First prompt

```text
Initialize this repository for the following project and agent role.

Project name: [Name]
Agent role: [Role and runner]
Purpose: [Intended outcomes]
Responsibilities: [Tasks the agent owns]
Boundaries: [Scope, source preservation, and approval requirements]
Runner and tools: [Available capabilities and setup still needed]
Deliverables: [Files, formats, and destinations]
Success checks: [Evidence needed to accept completed work]

Read AGENTS.md and README.md. Specialize the root README and every
existing README it lists, preserving useful guidance and project content.
Document actual capabilities and setup blockers. Update AGENTS.md under
600 words; keep CLAUDE.md as its adapter. Document the primary role and
add specialists only if needed. Explain short-term memory, long-term
decisions, and verified learnings; preserve memory/shorterm/.

Keep references in knowledge, procedures in skills, utilities in tools,
and deliverables in outputs. Verify links, paths, and consistency.

This request authorizes project README and AGENTS.md initialization
edits. Inspect capabilities; installations, external connections, and
production work need separate requests. Docker and infrastructure are
managed manually by the user. Preserve plan-led, batched execution.
Proceed with reasonable
assumptions and report changed files and remaining setup blockers.
```

## README files to customize

Keep this list aligned with project README files when setup changes.

| README | What it documents |
| --- | --- |
| [README.md](README.md) | Purpose, scope, manual setup ownership, skills, examples, and initialization |
| [tools/README.md](tools/README.md) | Actual tools, dependencies, diagnostics, and limitations |
| [roles/README.md](roles/README.md) | Primary Blender role and any necessary specialists |
| [memory/README.md](memory/README.md) | Finding, reviewing, and maintaining context |
| [memory/shorterm/README.md](memory/shorterm/README.md) | Active tasks and handoffs |
| [memory/longterm/README.md](memory/longterm/README.md) | Confirmed decisions and review triggers |
| [memory/learnings/README.md](memory/learnings/README.md) | Verified, reusable lessons |
| [evals/README.md](evals/README.md) | Manual cases and Blender acceptance checks |
| [outputs/README.md](outputs/README.md) | Deliverables, layout, naming, and versioning |
