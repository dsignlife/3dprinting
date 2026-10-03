$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$containerName = "3d-mcp-tools"

Write-Host "== Docker container =="
$running = docker inspect -f "{{.State.Running}}" $containerName 2>$null
if ($LASTEXITCODE -ne 0 -or (($running | Out-String).Trim() -ne "true")) {
    throw "Container '$containerName' is not running. Start it with: docker compose up -d"
}
Write-Host "Container running"

Write-Host "`n== Installed MCP tools =="
docker exec $containerName sh -lc "command -v mcp-for-blender" | Out-Null
if ($LASTEXITCODE -ne 0) { throw "mcp-for-blender is not installed." }

docker exec $containerName sh -lc "command -v bambu-printer-mcp" | Out-Null
if ($LASTEXITCODE -ne 0) { throw "bambu-printer-mcp is not installed." }

docker exec $containerName node --version
if ($LASTEXITCODE -ne 0) { throw "Node.js is not available." }

Write-Host "MCP tools installed"

Write-Host "`n== Mesh validation runtime =="
docker exec $containerName mesh-python -c "import trimesh, manifold3d, numpy; print('mesh tools OK')"
if ($LASTEXITCODE -ne 0) { throw "Mesh validation runtime check failed." }

Write-Host "`n== Windows SSH tunnel + Docker reachability =="
& (Join-Path $PSScriptRoot "check-blender-tunnel.ps1")

Write-Host "`nToolbox checks completed."
