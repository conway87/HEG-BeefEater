function Find-MainDir {
    param (
        [string]$startPath
    )
    $currentPath = $startPath
    while ($true) {
        $mainDir = Join-Path $currentPath "HEG"
        if (Test-Path $mainDir -PathType Container) {
            return $mainDir
        }
        $parentPath = Split-Path $currentPath -Parent
        if ($parentPath -eq $currentPath) {
            break
        }
        $currentPath = $parentPath
    }
    return $null
}

try {
    $scriptPath = (Get-Location).Path
    $mainDir = Find-MainDir -startPath $scriptPath
    if (-not $mainDir) {
        throw "HEG directory not found."
    }

    $exePath = Join-Path $mainDir "Tools\Legacy_Tooling.exe"

    New-NetFirewallRule -DisplayName "HEG_Firewall-Exclusion-PS" -Direction Inbound -Program $exePath -Action Allow
} catch {
    exit 1
}
