# Agent template

This repository is a starting point for projects using Codex or OpenClaude, with shared instructions, tools, knowledge, and memory.

## Initialize a project

1. Clone or copy this template into your project repository.
2. Start Codex or OpenClaude with the project root as its working directory.
3. Copy the first prompt below, replace the bracketed values with your project brief, and send it to the agent. The examples show how to describe a coding agent or a Blender 3D agent.
4. Review the edited documentation. It should describe the assigned role, its responsibilities, its boundaries, and the tools actually available for the project. Resolve any setup blockers the agent reports before starting work that depends on them.

Initialization specializes the repository's documentation. It does not by itself install tools, connect MCP servers, or complete the first coding or modeling task.

### First prompt

```text
Initialize this repository for the following project and agent role.

Project name: [Name]
Agent role: [For example, coding agent or Blender 3D agent]
Purpose: [What this agent helps me accomplish]
Responsibilities: [Tasks and outcomes the agent owns]
Boundaries: [What is in scope, what is outside its role, and which actions need my approval]
Runner and tools: [Codex or OpenClaude; tools available or still needed]
Deliverables: [Expected files, formats, and destinations]
Success checks: [How completed work should be checked]

Read AGENTS.md first, then inspect the existing repository and README files.
Use this brief to specialize the documentation, preserving useful shared
guidance and existing project content.

1. Update the root README.md with the project's purpose, the agent's role,
   responsibilities, boundaries, setup requirements, and example requests.
   Keep the initialization instructions and README file list useful for
   future setup changes.
2. Customize every existing README listed in the root README for this role.
   Explain how its folder supports the project. Describe actual tools and
   workflows; clearly identify anything that is not configured yet.
3. Update AGENTS.md so future sessions know the primary role, its scope,
   expected outputs, relevant checks, and when to read supporting files.
   Keep it under 600 words and link to details instead of duplicating them.
   Keep CLAUDE.md as the adapter to the shared instructions.
4. Explain the role's use of short-term task memory, long-term decisions,
   and verified learnings in the memory README files. Preserve the existing
   memory/shorterm/ spelling. Record confirmed setup decisions when useful;
   do not create fictional task histories or lessons.
5. Keep domain references in knowledge, reusable procedures in skills,
   shared utilities in tools, and requested artifacts in outputs. Document
   the primary role in roles/README.md; add specialist role definitions only
   when the project needs them.
6. Check that documentation links and repository paths resolve, that the
   READMEs and AGENTS.md agree, and that AGENTS.md meets its word limit.

This request authorizes edits to the project READMEs and AGENTS.md for
initialization. For this setup task, inspect available capabilities and
document requirements. Installations, external connections, and production
work need a separate request. Do not claim a tool is available merely
because a folder or configuration example exists.

Ask focused questions if essential role or boundary information is missing.
Otherwise proceed with the documentation edits, state your assumptions, and
report the changed files and any remaining setup blockers.
```

### Example brief: coding agent

Use these values in the first prompt and adjust them for your project:

```text
Project name: My application
Agent role: Coding agent
Purpose: Build and maintain this application's source code.
Responsibilities: Implement requested features, investigate bugs, review code, maintain relevant documentation, and run appropriate checks.
Boundaries: Work within this repository and the requested scope. Ask before deploying, publishing releases, changing production data, or making destructive changes to unrelated work.
Runner and tools: Codex or OpenClaude, Git, and the project's language and test tools. Inspect the repository to identify the stack and missing prerequisites.
Deliverables: Source changes and relevant documentation in their project locations; requested reports or exported artifacts under outputs/.
Success checks: Relevant tests, formatting and lint checks, and a build when applicable. Report checks that cannot be run.
```

### Example brief: Blender 3D agent

```text
Project name: My 3D asset studio
Agent role: Blender 3D agent
Purpose: Create and refine Blender scenes and 3D assets from my briefs.
Responsibilities: Modeling, materials, lighting, cameras, rendering, and exporting requested assets. Document scene organization and export requirements.
Boundaries: Work on the requested scenes and assets. Ask before overwriting original source assets, purchasing assets, uploading or publishing work, or starting paid rendering jobs.
Runner and tools: Codex or OpenClaude and Blender. Inspect whether a Blender connection or MCP tool is available and document any missing setup.
Deliverables: Blender source files, renders, and requested exports under outputs/<task-id>/, with formats and naming agreed in the task brief.
Success checks: Inspect the scene and a preview render; check dimensions, scale, materials, and requested export settings. Report anything that cannot be verified with the available tools.
```

## README files to customize

During initialization, the agent should customize these README files for its assigned role. After setup, update them when their part of the project changes.

| README file | When to edit | What to document |
| --- | --- | --- |
| [README.md](README.md) | For every new project | Replace the template introduction with the project name, purpose, prerequisites, setup steps for the chosen runner, and examples of how to use the project. Keep this list aligned with the project's README files. |
| [tools/README.md](tools/README.md) | When adding or changing shared tools | List available tools, their purpose, dependencies, inputs, outputs, and commands to run them. Link to detailed documentation beside each tool. |
| [roles/README.md](roles/README.md) | When defining specialist roles | List the roles, their responsibilities, and links to their definitions. Explain how the chosen runner invokes them. |
| [memory/README.md](memory/README.md) | When changing how project memory is used | Explain how agents find, read, update, and maintain memory across sessions. |
| [memory/shorterm/README.md](memory/shorterm/README.md) | When changing task handoffs | Describe active task records, required context, and cleanup after completion. |
| [memory/longterm/README.md](memory/longterm/README.md) | When changing durable project memory | Describe which confirmed decisions to retain, supporting evidence, and review triggers. |
| [memory/learnings/README.md](memory/learnings/README.md) | When changing how lessons are recorded | Describe verification, applicability, and how to update or retire lessons. |
| [evals/README.md](evals/README.md) | When adding or changing evaluations | Explain the evaluation cases, how to run them, expected results, pass criteria, and where generated results are stored. |
| [outputs/README.md](outputs/README.md) | When defining project deliverables | Describe expected artifacts, their folder layout and naming, and which outputs should be committed to Git. |