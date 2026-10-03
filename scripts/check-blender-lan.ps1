$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$envFile = Join-Path $repoRoot ".env"
$containerName = "3d-mcp-tools"

function Get-DotEnvValue {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [string]$Default = ""
    )

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

            $key = $trimmed.Substring(0, $separator).Trim()
            if ($key -ne $Name) { continue }

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

$blenderHost = Get-DotEnvValue "BLENDER_HOST"
$blenderPortText = Get-DotEnvValue "BLENDER_PORT" "9876"

if ([string]::IsNullOrWhiteSpace($blenderHost)) {
    throw "BLENDER_HOST is missing from '$envFile'. Set it to Computer 2's LAN IPv4 address."
}

$blenderPort = 0
if (-not [int]::TryParse($blenderPortText, [ref]$blenderPort) -or $blenderPort -lt 1 -or $blenderPort -gt 65535) {
    throw "BLENDER_PORT must be a valid TCP port from 1-65535."
}

Write-Host "== Computer 1 -> Computer 2 Blender MCP =="
Write-Host "Target: ${blenderHost}:${blenderPort}"

$nativeReady = Test-NetConnection $blenderHost -Port $blenderPort -InformationLevel Quiet -WarningAction SilentlyContinue

if (-not $nativeReady) {
    throw @"
Computer 1 cannot reach ${blenderHost}:${blenderPort}.

On Computer 2 verify:
1. Blender is running.
2. Blender MCP server is started.
3. The Blender MCP listener is bound to a LAN-reachable address, not only 127.0.0.1.
4. Windows Firewall allows TCP $blenderPort from Computer 1's LAN IP.
"@
}

Write-Host "Computer 1 can reach Blender MCP."

Write-Host "`n== Docker -> Computer 2 Blender MCP =="

$running = docker inspect -f "{{.State.Running}}" $containerName 2>$null
if ($LASTEXITCODE -ne 0 -or (($running | Out-String).Trim() -ne "true")) {
    Write-Host "Container '$containerName' is not running yet."
    Write-Host "Build/start it with: docker compose up -d --build"
    exit 0
}

docker exec $containerName sh -lc 'nc -z "$BLENDER_HOST" "$BLENDER_PORT"' 2>$null | Out-Null

if ($LASTEXITCODE -ne 0) {
    throw @"
Computer 1 can reach Blender, but Docker cannot.

Verify compose.yaml passes:
  BLENDER_HOST: "${BLENDER_HOST}"
  BLENDER_PORT: "${BLENDER_PORT:-9876}"

Then recreate the container:
  docker compose up -d --force-recreate
"@
}

Write-Host "Docker can reach Blender MCP at ${blenderHost}:${blenderPort}."
Write-Host "`nDirect LAN Blender path is ready."
