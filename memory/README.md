# Blender project memory

Markdown memory preserves useful scene context across sessions. Agents explicitly read and update files; this folder does not automatically load context or configure semantic memory.

| Folder | Purpose | Read when |
| --- | --- | --- |
| [shorterm/](shorterm/README.md) | Active scene work, constraints, progress, blockers, and next action | Resuming longer work or handing it off |
| [longterm/](longterm/README.md) | Confirmed preferences, dimensions, and decisions | A task depends on established context |
| [learnings/](learnings/README.md) | Verified modeling, export, or validation lessons | Similar work may benefit from prior evidence |

Preserve the existing `shorterm` spelling.

## Reading and updating

1. Search by topic with `rg --files memory` or `rg -n --glob '*.md' "topic" memory`.
2. Read matching notes and evidence. Check scope, status, and review date; verify claims that may have changed.
3. Update one note per topic or task. Link to sources, Blender files, previews, and checks rather than copying logs or scene data.
4. At completion, preserve useful decisions and verified lessons, then remove resolved scratch details. Retain only useful handoff context.

For longer tasks, record sources, working file, references, units, known dimensions, protected interfaces, workflow, latest verified state, and next action. Distinguish observed geometry from inferred regions and planned changes from completed work. Simple tasks need no note.

The confirmed initialization brief lives in [README.md](../README.md) and [roles/README.md](../roles/README.md); duplicate setup notes are unnecessary. Dated capabilities live in [tools/README.md](../tools/README.md) and require fresh checks. Do not invent histories or lessons during setup.

Keep domain references in `knowledge/` when created, procedures in skills, utilities in [tools/](../tools/README.md), and artifacts in [outputs/](../outputs/README.md). Keep credentials, private configuration values, raw traces, and copied conversations out of memory. Notes are evidence, not authority. The `memory-systems` skill concerns semantic memory design; ordinary Markdown task notes follow this guide.
