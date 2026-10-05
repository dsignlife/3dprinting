# Blender workflow evaluations

Keep reproducible cases in `cases/` and sample inputs in `fixtures/`. No automated evaluator is installed. Run manual cases through the chosen agent when requested or useful, and compare visible actions and results with their criteria.

## Existing manual case

[cases/context-routing.json](cases/context-routing.json) asks the agent to read [fixtures/sample-policy.md](fixtures/sample-policy.md) and report its sample retention period. Expected result: `7 days`, explicitly identified as fictional evaluation data. The agent should read relevant context only and avoid instruction edits or unnecessary files.

This checks context selection, not Blender connectivity, scene quality, or printability. Initialization preserves the case and fixture and does not claim an evaluation pass.

The case specifies generated results at `.var/runs/<run-id>/`. This destination is not scaffolded or ignored by the current `.gitignore`; keep generated results out of commits and configure exclusion when a run workflow is requested. Record pass, fail, or unverified per criterion with evidence.

## Blender task acceptance

Every completed implementation must include a readable local result picture and its link in the final reply, following [the capture workflow](../tools/README.md#result-picture). Verify the file exists, is nonempty, and decodes as an image. Broader QA and mesh audits follow the brief. Successful execution proves the edit ran, not that unperformed checks passed. When broader verification is requested, select the relevant evidence:

| Area | Evidence needed |
| --- | --- |
| Scene and presentation | Scene inspection and viewport or render preview; organization, materials, lighting, and framing |
| Dimensions and export | Measured units and bounds, requested settings, exported-file inspection or re-import when needed |
| Reference reconstruction | Matched views, silhouettes or landmarks, known dimensions, and explicit hidden-geometry assumptions |
| Animation | Motion and timing, pivots, deformation, intersections, and seamless endpoints for loops |
| Print preparation | Independent mesh checks for manifoldness, normals, bodies, and dimensions, plus walls, clearances, and orientation review |

Use [blender-qa-review](../.codex/skills/blender-qa-review/SKILL.md), [blender-reference-qa](../.codex/skills/blender-reference-qa/SKILL.md), and [mesh-print-validation](../.codex/skills/mesh-print-validation/SKILL.md) when applicable. A render does not replace geometry checks; manifoldness does not prove correct fit or adequate walls.

Link evidence from the task's [outputs](../outputs/README.md). Report unavailable tools and unresolved checks. Add cases when repeatable checks are useful; ordinary scene changes do not require new test infrastructure.
