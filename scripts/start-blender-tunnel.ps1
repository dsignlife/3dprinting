$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDir
$envFile = Join-Path $repoRoot ".env"

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

            if (-not $trimmed -or $trimmed.StartsWith("#")) {
                continue
            }

            $separator = $trimmed.IndexOf("=")
            if ($separator -lt 1) {
                continue
            }

            $key = $trimmed.Substring(0, $separator).Trim()
            if ($key -ne $Name) {
                continue
            }

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

function Require-Value {
    param([string]$Name, [string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        throw "Required setting '$Name' is missing. Add it to '$envFile'."
    }

    return $Value
}

function Get-MatchingTunnelProcesses {
    param(
        [string]$ForwardSpec,
        [string]$RemoteTarget,
        [string]$PrivateKey
    )

    $escapedForward = [Regex]::Escape($ForwardSpec)
    $escapedRemote = [Regex]::Escape($RemoteTarget)
    $escapedKey = [Regex]::Escape($PrivateKey)

    Get-CimInstance Win32_Process -Filter "Name = 'ssh.exe'" -ErrorAction SilentlyContinue |
        Where-Object {
            $_.CommandLine -and
            $_.CommandLine -match $escapedForward -and
            $_.CommandLine -match $escapedRemote -and
            $_.CommandLine -match $escapedKey
        }
}

$sshHost = Require-Value "BLENDER_SSH_HOST" (Get-DotEnvValue "BLENDER_SSH_HOST")
$sshUser = Require-Value "BLENDER_SSH_USER" (Get-DotEnvValue "BLENDER_SSH_USER")
$sshPortText = Get-DotEnvValue "BLENDER_SSH_PORT" "22"
$blenderPortText = Get-DotEnvValue "BLENDER_PORT" "9876"

$sshPort = 0
if (-not [int]::TryParse($sshPortText, [ref]$sshPort) -or $sshPort -lt 1 -or $sshPort -gt 65535) {
    throw "BLENDER_SSH_PORT must be a TCP port from 1-65535."
}

$blenderPort = 0
if (-not [int]::TryParse($blenderPortText, [ref]$blenderPort) -or $blenderPort -lt 1 -or $blenderPort -gt 65535) {
    throw "BLENDER_PORT must be a TCP port from 1-65535."
}

$keyPath = Join-Path $scriptDir "blender_mcp"
$knownHostsPath = Join-Path $scriptDir "blender_known_hosts"

if (-not (Test-Path -LiteralPath $keyPath -PathType Leaf)) {
    throw "Missing SSH private key: $keyPath"
}
if ((Get-Item -LiteralPath $keyPath).Length -eq 0) {
    throw "The SSH private-key placeholder is still empty: $keyPath"
}

if (-not (Test-Path -LiteralPath $knownHostsPath -PathType Leaf)) {
    throw "Missing SSH known-hosts file: $knownHostsPath"
}
if ((Get-Item -LiteralPath $knownHostsPath).Length -eq 0) {
    throw "The SSH known-hosts placeholder is still empty: $knownHostsPath"
}

$sshCommand = Get-Command ssh.exe -ErrorAction SilentlyContinue
if (-not $sshCommand) {
    throw "Windows OpenSSH client (ssh.exe) was not found. Install the Windows OpenSSH Client feature."
}

$keyPath = (Resolve-Path -LiteralPath $keyPath).Path
$knownHostsPath = (Resolve-Path -LiteralPath $knownHostsPath).Path

$forwardSpec = "127.0.0.1:${blenderPort}:127.0.0.1:${blenderPort}"
$remoteTarget = "${sshUser}@${sshHost}"

$existingTunnel = @(Get-MatchingTunnelProcesses `
    -ForwardSpec $forwardSpec `
    -RemoteTarget $remoteTarget `
    -PrivateKey $keyPath)

if ($existingTunnel.Count -gt 0) {
    Write-Host "Blender SSH tunnel is already running on Computer 1."
    Write-Host "Windows endpoint: 127.0.0.1:$blenderPort"
    Write-Host "Remote endpoint:  $sshHost -> 127.0.0.1:$blenderPort"
    exit 0
}

$listener = Get-NetTCPConnection -State Listen -LocalPort $blenderPort -ErrorAction SilentlyContinue |
    Where-Object { $_.LocalAddress -in @("127.0.0.1", "0.0.0.0", "::", "::1") }

if ($listener) {
    throw "Local port $blenderPort is already listening on Computer 1, but it is not this Blender SSH tunnel."
}

$sshArgs = @(
    "-N"
    "-L", $forwardSpec
    "-p", "$sshPort"
    "-i", $keyPath
    "-o", "IdentitiesOnly=yes"
    "-o", "BatchMode=yes"
    "-o", "ExitOnForwardFailure=yes"
    "-o", "ServerAliveInterval=30"
    "-o", "ServerAliveCountMax=3"
    "-o", "TCPKeepAlive=yes"
    "-o", "StrictHostKeyChecking=yes"
    "-o", "UserKnownHostsFile=$knownHostsPath"
    $remoteTarget
)

Write-Host "Starting Blender SSH tunnel on Computer 1..."
Write-Host "Local:  127.0.0.1:$blenderPort"
Write-Host "Remote: $sshHost -> 127.0.0.1:$blenderPort"
Write-Host ""
Write-Host "Keep this PowerShell window open."
Write-Host "Press Ctrl+C to close the tunnel."
Write-Host ""

& $sshCommand.Source @sshArgs

if ($LASTEXITCODE -ne 0) {
    throw "SSH tunnel exited with code $LASTEXITCODE."
}
