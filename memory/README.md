# Director memory

Memory preserves the Director's coordination context between tasks and across Codex and OpenClaude sessions. It consists of Markdown files that agents explicitly read and update with their file tools. This folder does not automatically load context or enable a runner's built-in memory feature.

## Choose a folder

| Folder | Purpose | Read when |
| --- | --- | --- |
| [shorterm/](shorterm/README.md) | Active plans, assignments, dependencies, returned results, blockers, and next actions | Resuming work or deciding what happens next |
| [longterm/](longterm/README.md) | Confirmed preferences, project decisions, and established coordination conventions | Planning depends on durable context |
| [learnings/](learnings/README.md) | Verified lessons from planning and specialist work | Reviewing a similar solution, assignment, or result |

The existing folder name is `shorterm`; use that spelling in paths.

## How agents use memory

1. Identify the task or topic. Locate relevant files with `rg --files memory` or search their content with `rg -n --glob '*.md' "topic" memory`.
2. Read the matching notes and supporting sources. Load only context needed for the current task.
3. Check each note's scope, evidence, status, and review date. Memory is supporting evidence; the current user request and applicable instructions take priority. Verify claims that may have changed and label unresolved assumptions.
4. Update the existing note when useful context changes. Use descriptive filenames such as `runner-selection.md` or a task identifier. Keep one current note per topic or task and link to artifacts rather than copying their contents.

When consuming a specialist return, distinguish what the specialist reported from what the Director verified and accepted. Record the resulting decision and next action. A prepared brief remains `awaiting dispatch` until actual runner execution or an external handoff is confirmed.

## Keeping memory useful

Simple tasks usually need no memory entry. Record information when it supports a handoff, preserves a decision, or prevents repeating a verified mistake. Before closing longer work, preserve relevant durable decisions in `longterm/` and reusable lessons in `learnings/`, then remove resolved scratch details from the task note. Keep a concise completion status when a handoff still needs it.

Keep one live task record for a goal instead of separate transcripts for every specialist. Link to their artifacts and summarize the evidence needed for the next decision. Never invent task histories, dispatches, or lessons during setup.

When the `planning-with-files` skill manages a task, its selected planning files hold the live plan. Link to them from a short-term handoff note when needed instead of duplicating the plan. The `memory-systems` skill applies to semantic memory design and retrieval; ordinary Markdown coordination notes use this guidance.

Keep domain facts and policies in [knowledge/](../knowledge/INDEX.md), reusable procedures in skills, and deliverables in [outputs/](../outputs/README.md). Link to those sources from memory. Keep credentials, raw logs, and copied conversations out of memory. Update or retire stale notes instead of accumulating contradictory versions.
