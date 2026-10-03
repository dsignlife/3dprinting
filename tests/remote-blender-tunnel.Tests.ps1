$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$failures = [System.Collections.Generic.List[string]]::new()

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { $failures.Add($Message) }
}

function Test-PowerShellSyntax {
    param([string]$Path)
    $tokens = $null
    $errors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$tokens, [ref]$errors) | Out-Null
    Assert-True ($errors.Count -eq 0) "PowerShell syntax errors in $Path"
}

$required = @(
    "scripts/start-blender-tunnel.ps1",
    "scripts/check-blender-tunnel.ps1",
    "scripts/stop-blender-tunnel.ps1",
    "scripts/check-toolbox.ps1",
    "scripts/blender_mcp",
    "scripts/blender_mcp.pub",
    "scripts/blender_known_hosts"
)

foreach ($relative in $required) {
    Assert-True (Test-Path -LiteralPath (Join-Path $repoRoot $relative) -PathType Leaf) "Missing required file: $relative"
}

Assert-True (-not (Test-Path -LiteralPath (Join-Path $repoRoot "scripts/start-blender-tunnel.sh"))) `
    "Old Docker-side scripts/start-blender-tunnel.sh must be removed"

foreach ($relative in $required | Where-Object { $_ -like "*.ps1" }) {
    Test-PowerShellSyntax (Join-Path $repoRoot $relative)
}

$gitignore = Get-Content -LiteralPath (Join-Path $repoRoot ".gitignore") -Raw
Assert-True ($gitignore -match '/scripts/blender_mcp') "Private key must be gitignored"
Assert-True ($gitignore -match '/scripts/blender_mcp\.pub') "Public key copy must be gitignored"
Assert-True ($gitignore -match '/scripts/blender_known_hosts') "known_hosts must be gitignored"

$compose = Get-Content -LiteralPath (Join-Path $repoRoot "compose.yaml") -Raw
Assert-True ($compose -match 'BLENDER_HOST:\s*host\.docker\.internal') `
    "Docker Blender MCP must connect to the Windows host tunnel"
Assert-True ($compose -notmatch 'BLENDER_SSH_HOST:') `
    "Docker Compose should not own the SSH tunnel configuration"
Assert-True ($compose -notmatch 'SSH_DIR') `
    "Docker Compose must not mount an SSH directory"

$start = Get-Content -LiteralPath (Join-Path $repoRoot "scripts/start-blender-tunnel.ps1") -Raw
Assert-True ($start -match 'ssh\.exe') "Windows tunnel must use native ssh.exe"
Assert-True ($start -match 'scripts') "Windows tunnel should resolve repo-local script files"
Assert-True ($start -match 'blender_mcp') "Windows tunnel must use the repo-local private key"
Assert-True ($start -match 'blender_known_hosts') "Windows tunnel must use repo-local known_hosts"
Assert-True ($start -match 'StrictHostKeyChecking=yes') "Host-key checking must remain enabled"
Assert-True ($start -notmatch 'docker exec.+start-blender-tunnel') `
    "Windows tunnel script must not launch the tunnel inside Docker"

$check = Get-Content -LiteralPath (Join-Path $repoRoot "scripts/check-blender-tunnel.ps1") -Raw
Assert-True ($check -match 'Test-NetConnection\s+127\.0\.0\.1') `
    "Tunnel check must verify the native Windows endpoint"
Assert-True ($check -match 'host\.docker\.internal') `
    "Tunnel check must verify Docker can reach the Windows endpoint"

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Error $failure -ErrorAction Continue
    }
    throw "$($failures.Count) remote Blender tunnel test(s) failed."
}

Write-Host "Windows-hosted Blender SSH tunnel static tests passed."
