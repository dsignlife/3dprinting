$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$envFile = Join-Path $repoRoot ".env"
$containerName = "3d-mcp-tools"

function Get-DotEnvValue {
    param([string]$Name, [string]$Default = "")

    $processValue = [Environment]::GetEnvironmentVariable($Name, "Process")
    if (-not [string]::IsNullOrWhiteSpace($processValue)) {
        return $processValue.Trim()
    }

    if (Test-Path -LiteralPath $envFile -PathType Leaf) {
        foreach ($line in Get-Content -LiteralPath $envFile) {
            $trimmed = $line.Trim()
            if (-not $trimmed -or $trimmed.StartsWith("#")) { continue }

            $separator = $trimmed.IndexOf("=")
            if ($separator -lt 1) { continue }

            if ($trimmed.Substring(0, $separator).Trim() -ne $Name) { continue }

            $value = $trimmed.Substring($separator + 1).Trim()
            if (
                ($value.StartsWith('"') -and $value.EndsWith('"')) -or
                ($value.StartsWith("'") -and $value.EndsWith("'"))
            ) {
                if ($value.Length -ge 2) {
                    $value = $value.Substring(1, $value.Length - 2)
                }
            }
            return $value
        }
    }

    return $Default
}

$portText = Get-DotEnvValue "BLENDER_PORT" "9876"
$port = 0
if (-not [int]::TryParse($portText, [ref]$port) -or $port -lt 1 -or $port -gt 65535) {
    throw "Invalid BLENDER_PORT in .env."
}

Write-Host "== Computer 1 Windows tunnel endpoint =="

$windowsReady = Test-NetConnection 127.0.0.1 -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue

if ($windowsReady) {
    Write-Host "Windows tunnel endpoint reachable: 127.0.0.1:$port"
}
else {
    throw "Nothing is reachable on Computer 1 at 127.0.0.1:$port. Start .\scripts\start-blender-tunnel.ps1 first."
}

Write-Host "`n== Docker -> Computer 1 tunnel =="

$running = docker inspect -f "{{.State.Running}}" $containerName 2>$null
if ($LASTEXITCODE -ne 0 -or (($running | Out-String).Trim() -ne "true")) {
    throw "Container '$containerName' is not running. Start it with: docker compose up -d"
}

docker exec $containerName sh -lc 'nc -z host.docker.internal "${BLENDER_PORT:-9876}"' 2>$null | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker can reach the Windows SSH tunnel at host.docker.internal:$port"
}
else {
    throw @"
Windows tunnel is running, but Docker cannot reach host.docker.internal:$port.

Check Docker Desktop networking and confirm compose.yaml uses:
  BLENDER_HOST: host.docker.internal

Do not change the Blender MCP to 127.0.0.1 inside Docker.
"@
}

Write-Host "`nBlender SSH tunnel path is ready."
