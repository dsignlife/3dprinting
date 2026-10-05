# Director tools and capabilities

The Director uses runner tools to inspect context, coordinate agents, read returned artifacts, and perform appropriate verification. Substantial implementation belongs to specialists described in [roles/](../roles/README.md).

## Initialization inventory

Observed during documentation initialization on 2026-10-05. Recheck in the current session before assigning work; PATH discovery does not establish authentication or tool health.

| Capability | Observed state | Next check |
| --- | --- | --- |
| Codex | `codex.exe` found on PATH | Confirm the chosen runner can access the project and required tools |
| Git | `git.exe` found on PATH | Inspect branch and working-tree state before edits |
| OpenClaude | Command not found on PATH | Confirm its installation and launch method if selected |
| Agent coordination | Spawn, message, follow-up, and wait tools exposed in the initialization session | Check actual coordination tools and available specialist capabilities in each session |
| Blender | Command not found on PATH; no direct Blender tool observed in the session tool list | Confirm Blender's location and a working execution or MCP connection before Blender assignments |
| Project MCP configuration | [.mcp.json.example](../.mcp.json.example) contains an empty server map; no live project MCP file was present | Configure and verify project connections when separately requested |
| Codex skills | Six `SKILL.md` manifests present in `.codex/skills/` and exposed in the current Codex session | Use the [skill routing table](../README.md#skills-the-director-uses); read the matching skill before acting |
| OpenClaude skills | Local `.openclaude/skills/` scaffold is empty | Verify OpenClaude discovery separately; empty folders are not preserved by Git |
| Repository utilities | No executable utilities in this folder | Use native runner tools; add a shared utility only when needed |

Personal-assistant integrations depend on the current runner and the user's authorized accounts and actions. This repository supplies no dedicated personal-assistant connection. Discovered tools are capabilities, not permission to use them for unrelated actions.

Installed skill instructions and supporting resources are available to read. Scripts and lifecycle hooks bundled with a skill still need their required shell, dependencies, and runner support; this inventory does not establish that every helper or hook has run successfully.

## Delegation and verification

Check that a specialist has the tools, files, and permissions required by its brief before dispatch. Runner subagents may share the current workspace; assigning a role does not provision a separate repository or application. Use explicit file ownership and identify any external specialist workspace in the handoff.

If execution is unavailable, return a ready-to-send brief marked `awaiting dispatch`. Preserve that status until a real dispatch occurs. If verification is unavailable, record what was inspected and what remains unverified.

Add executable utilities here only when shared across workflows. Document inputs, outputs, dependencies, and invocation beside each utility. Skill-specific helpers belong with their skill. Scripts and configuration examples need runner-supported registration before they become callable tools. Keep credentials out of documentation and committed configuration.
