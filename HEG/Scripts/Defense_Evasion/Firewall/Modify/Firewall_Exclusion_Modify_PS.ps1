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
            return $null
        }
        $currentPath = $parentPath
    }
}

$scriptPath = (Get-Location).Path
$mainDir = Find-MainDir -startPath $scriptPath

if ($mainDir) {
    $exePath = Join-Path $mainDir "Tools\Updated_Tooling.exe"
    Set-NetFirewallRule -DisplayName "HEG_Firewall-Exclusion-PS" -Program $exePath
}