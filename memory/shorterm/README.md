# Short-term memory

Use this folder for the Director's active plans and task context that another session or agent needs to continue the work. Follow the shared [memory guidance](../README.md).

Create a task note for work spanning sessions or requiring a handoff. Read it before resuming that task. Update it after a meaningful decision, change in status, or handoff; keep the current state instead of a running conversation log.

Use a filename such as `<task-id>.md` and include:

```markdown
# Task title

- Goal:
- Constraints:
- Acceptance criteria:
- Owner:
- Status: active / blocked / complete
- Last updated: YYYY-MM-DD

## Plan and dependencies
Sequenced tasks, recommended approach, and readiness conditions.

## Assignments
For each task: specialist, workspace, owned files or artifacts,
dependencies, brief link, actual dispatch reference when available,
and state: awaiting dispatch / dispatched / returned / correction needed / accepted.

## Returned results and decisions
Reported findings, Director verification, acceptance or correction decision,
and remaining uncertainties. Link to evidence instead of copying logs.

## Artifacts
Links to relevant files, outputs, and supporting sources.

## Next action
The concrete next step, responsible agent, and any unresolved blocker.
```

Use assignment briefs from [roles/README.md](../../roles/README.md). Update the live record after dispatch, a returned result, a review decision, or a meaningful blocker. Keep reported completion separate from accepted work; do not mark the overall goal complete while required tasks or checks remain unresolved.

When work finishes, move useful project decisions to [longterm/](../longterm/README.md) and verified reusable lessons to [learnings/](../learnings/README.md). Remove resolved scratch details. Retain only the completion context needed for a handoff; remove obsolete task notes when no longer useful.
