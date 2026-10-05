# Director evaluations

Keep versioned cases in `cases/` and deterministic sample inputs in `fixtures/`. Store generated run results, latency, cost, and traces in `.var/runs/<run-id>/`.

The `.var/` location is reserved for generated results and is not currently scaffolded. Create a run destination only when executing an evaluation. No automated evaluator is installed.

`cases/context-routing.json` is a manual starter evaluation for the context-routing behavior. It uses a fictional fixture, not actual business policy. Run it through the chosen agent, inspect its visible tool trace and response, and compare against the criteria. There is no automated evaluator installed.

Add cases when a workflow needs a repeatable quality check. Do not turn every transient error into a permanent evaluation.

## Director checks

Before accepting a plan or result, check that it:

- Preserves the user's goal, constraints, and acceptance criteria.
- Gives each specialist a bounded objective, relevant inputs, dependencies, ownership, concrete guidance, and expected return evidence.
- Avoids concurrent writers owning the same files or artifacts.
- Distinguishes prepared briefs, actual dispatch, returned results, and accepted work.
- Bases acceptance on inspected artifacts and suitable verification, recording unavailable checks explicitly.
- Gives the next action and updates current task state without repeating completed work.

Use small hypothetical scenarios to review these behaviors manually: a missing Blender connection should leave a brief awaiting dispatch; a failed coding check should trigger a correction request; an unsupported completion claim should remain awaiting evidence. These are evaluation scenarios, not recorded production results.

For a manual evaluation, read the case and its relevant fixture, give its prompt to the chosen agent, and compare the visible response and tool trace with the criteria. Report pass, fail, or unverified for each criterion. Capture generated results only when running the evaluation. This documentation initialization does not execute another agent or establish passing production behavior.
