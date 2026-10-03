# AGENTS.md — Blender + Bambu P2S Codex Workspace

## Role

This repository is for creating and preparing 3D-printable objects using:

- Codex in VS Code on Computer 1
- Blender MCP inside Docker on Computer 1
- a manually started Windows SSH tunnel on Computer 1
- Blender running on Computer 2 over the LAN
- Bambu Lab P2S MCP inside Docker

Use screenshots, reference files, measurements, and supplied implementation specs as the source of design intent.

Use repo-scoped skills under `.codex/skills/`.

## Blender connection architecture

The SSH tunnel is NOT inside Docker.

The user manually runs:

```text
scripts/start-blender-tunnel.ps1
```

on Computer 1 Windows.

Connection path:

```text
Codex / VS Code
      ↓
docker exec -i
      ↓
mcp-for-blender inside 3d-mcp-tools
      ↓
host.docker.internal:9876
      ↓
Computer 1 Windows SSH tunnel
      ↓
Computer 2 SSH server
      ↓
Computer 2 localhost:9876
      ↓
Blender MCP addon
      ↓
Blender
```

If Blender MCP is unavailable:

1. do not rewrite MCP configuration immediately;
2. check `scripts/check-blender-tunnel.ps1`;
3. confirm the Windows tunnel is running;
4. confirm Docker can reach `host.docker.internal:$BLENDER_PORT`;
5. confirm Blender MCP is running on Computer 2 localhost.

Docker must use:

```text
BLENDER_HOST=host.docker.internal
```

Do NOT change Docker Blender host to `127.0.0.1`; inside Docker that would refer to the container itself.

## SSH files

Local-only files beside the PowerShell scripts:

- `scripts/blender_mcp` — Computer 1 private key
- `scripts/blender_mcp.pub` — matching public key copied to Computer 2 `authorized_keys`
- `scripts/blender_known_hosts` — verified Computer 2 SSH host key

These files are gitignored.

Never print, commit, rewrite, upload, or expose the private key.

## Blender execution

- Use the `blender` MCP server for Blender inspection and edits.
- Inspect the current Blender scene before destructive changes.
- Prefer numeric dimensions and transforms for fit-critical geometry.
- Preserve dimensions identified as CRITICAL.
- Prefer non-destructive modifier workflows while iterating.
- Never use visual eyeballing as the only validation for functional dimensions.
- Blender runs outside Docker; do not install or launch Blender in Docker.

## Mesh validation

Before declaring a model print-ready:
- verify dimensions;
- check normals;
- check manifold/watertight state where applicable;
- check disconnected bodies;
- validate exported STL/3MF when possible.

The MCP toolbox contains:
- `mesh-python`
- `trimesh`
- `manifold3d`
- `numpy`
- `Pillow`

The repo is mounted in the toolbox at `/workspace`.

## Bambu Lab P2S

- Use the `bambu` MCP for printer state, AMS/material information, file workflow, and print operations.
- Printer secrets are injected privately through Docker `.env`.
- Never echo, expose, or commit the LAN access code/token.
- Never start, cancel, pause, resume, heat, move hardware, or load/unload filament unless the user explicitly requests that physical action.
- Modeling/exporting/slicing/preparing/uploading does NOT authorize starting a physical print.
- Connection/setup tests must be read-only.

## Screenshots

The user may paste screenshots directly into Codex in VS Code.
Use them as visual references and use Blender MCP inspection/numeric checks for implementation.

## Files

Prefer:
- `references/`
- `specs/`
- `models/`
- `output/`

Never commit `.env`.
