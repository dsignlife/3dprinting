$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$envFile = Join-Path $repoRoot ".env"

function Get-DotEnvValue {
    param([string]$Name, [string]$Default = "")

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

$sshHost = Get-DotEnvValue "BLENDER_SSH_HOST"
$sshUser = Get-DotEnvValue "BLENDER_SSH_USER"
$portText = Get-DotEnvValue "BLENDER_PORT" "9876"

if (-not $sshHost -or -not $sshUser) {
    throw "BLENDER_SSH_HOST and BLENDER_SSH_USER must exist in .env."
}

$port = 0
if (-not [int]::TryParse($portText, [ref]$port)) {
    throw "Invalid BLENDER_PORT in .env."
}

$keyPath = Join-Path $scriptDir "blender_mcp"
if (-not (Test-Path -LiteralPath $keyPath -PathType Leaf)) {
    throw "Missing SSH private key: $keyPath"
}
$keyPath = (Resolve-Path -LiteralPath $keyPath).Path

$forwardSpec = "127.0.0.1:${port}:127.0.0.1:${port}"
$remoteTarget = "${sshUser}@${sshHost}"

$escapedForward = [Regex]::Escape($forwardSpec)
$escapedRemote = [Regex]::Escape($remoteTarget)
$escapedKey = [Regex]::Escape($keyPath)

$matches = @(
    Get-CimInstance Win32_Process -Filter "Name = 'ssh.exe'" -ErrorAction SilentlyContinue |
        Where-Object {
            $_.CommandLine -and
            $_.CommandLine -match $escapedForward -and
            $_.CommandLine -match $escapedRemote -and
            $_.CommandLine -match $escapedKey
        }
)

if ($matches.Count -eq 0) {
    Write-Host "No matching Blender SSH tunnel process is running."
    exit 0
}

foreach ($process in $matches) {
    Stop-Process -Id $process.ProcessId -Force
    Write-Host "Stopped Blender SSH tunnel process PID $($process.ProcessId)."
}
