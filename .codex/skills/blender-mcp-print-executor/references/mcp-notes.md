# Blender MCP notes

Blender itself runs natively on Windows.

The Docker toolbox runs:
- `mcp-for-blender`

Connection defaults:
- `BLENDER_HOST=host.docker.internal`
- `BLENDER_PORT=9876`
- `BLENDER_MCP_SAFE_MODE=1`

Codex connects using:

`docker exec -i 3d-mcp-tools mcp-for-blender`

Always discover the installed MCP server's current tools/schemas rather than inventing tool names.
