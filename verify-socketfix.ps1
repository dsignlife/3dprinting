$ErrorActionPreference = "Stop"

Write-Host "Checking patched mcp-for-blender installation..."
docker exec 3d-mcp-tools sh -lc 'uv tool list'

Write-Host "Checking socket screenshot implementation..."
docker exec 3d-mcp-tools sh -lc '/opt/uv/tools/mcp-for-blender/bin/python -c "import inspect, blender_mcp.server as s; x=inspect.getsource(s._capture_viewport); assert \"return_data\" in x; print(\"socket screenshot fix OK\")"'

Write-Host "Checking Blender TCP connection..."
docker exec 3d-mcp-tools sh -lc 'echo "$BLENDER_HOST:$BLENDER_PORT"; nc -vz "$BLENDER_HOST" "$BLENDER_PORT"'

Write-Host "All container-side checks passed. Next verify get_addon_status reports protocol 14 in Codex."
