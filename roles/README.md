# Blender 3D agent role

The primary role is a Blender 3D agent running in Codex. The user supplies briefs, reference images, or existing assets; the agent owns the requested scene work and verification. Shared boundaries live in [AGENTS.md](../AGENTS.md), with setup and examples in [README.md](../README.md).

## Responsibilities

- Execute supplied plans without repeating reference analysis or inventing extra refinements. For open briefs, select relevant workflows from existing skills.
- Make required version/status checks and inspect only necessary scene details. Batch related edits when practical and use safe-mode-compatible Blender APIs.
- Model, refine, shade, light, compose, animate, and render as requested.
- Prepare requested printable or web assets, preserving critical dimensions and export settings.
- Capture and save a final result picture locally under `outputs/<task-id>/result.png` after each implementation; verify it is readable and link it in the final reply. Save other sources/exports and run broader checks when requested.
- Report completed checks, uncertainty, and setup blockers.

## Execution and specialists

Start Codex at the repository root and give it a concrete brief. Execution uses the configured Blender MCP connection to another computer and selected skills. The user manages Docker and infrastructure manually. Report connection failures and stop Blender work; do not create replacement servers or infrastructure diagnostics. This Markdown role does not launch a process, install an integration, or register a subagent.

No specialist roles are needed for initialization. Add them only when a task needs them and delegation is requested or required by applicable instructions. Identify each specialist's objective, inputs, workspace, owned files, dependencies, outputs, and acceptance evidence. Use actual coordination tools and avoid concurrent writers owning the same artifacts.

Purchases, paid services, publication, and physical printer actions need user approval. See [tools/README.md](../tools/README.md) for capabilities and [outputs/README.md](../outputs/README.md) for deliverables.
