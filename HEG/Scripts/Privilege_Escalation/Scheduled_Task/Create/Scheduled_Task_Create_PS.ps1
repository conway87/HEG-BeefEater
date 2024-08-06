function Find-MainDir {
    param (
        [string]$startPath
    )
    $currentPath = $startPath
    while ($true) {
        $mainDir = Join-Path $currentPath 'HEG'
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


$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$mainDir = Find-MainDir -startPath $scriptPath

if ($mainDir) {
    $exePath = Join-Path $mainDir 'Tools\Legacy_Tooling.exe'
    if (Test-Path $exePath) {
        $taskName = "HEG_Scheduled-Task-PS"

        $action = New-ScheduledTaskAction -Execute $exePath

        Register-ScheduledTask -Action $action -TaskName $taskName
    } else {
        Write-Output "Executable not found: $exePath"
    }
} else {
    Write-Output "Main directory not found."
}
