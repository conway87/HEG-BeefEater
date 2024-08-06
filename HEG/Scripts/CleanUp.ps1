# Registry Key Cleanup
$registryKeysToDelete = @(
    "HKCU:\Console\HEG_Registry-Key-CMD",
    "HKCU:\Console\HEG_Registry-Key-JS",
    "HKCU:\Console\HEG_Registry-Key-PS",
    "HKCU:\Console\HEG_Registry-Key-VBS"
)

foreach ($registryKey in $registryKeysToDelete) {
    try {
        Remove-Item -Path $registryKey -Recurse -Force -ErrorAction Stop
    } catch {
        # Handle errors silently
    }
}




# Scheduled Task Cleanup
$tasksToDelete = @(
    "HEG_Scheduled-Task-CMD",
    "HEG_Scheduled-Task-JS",
    "HEG_Scheduled-Task-PS",
    "HEG_Scheduled-Task-VBS"
)

foreach ($taskName in $tasksToDelete) {
    try {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction Stop
    } catch {
        # Handle errors silently
    }
}





# Services Cleanup
$servicesToDelete = @(
    "HEG_Service-CMD",
    "HEG_Service-PS"
)

foreach ($serviceName in $servicesToDelete) {
    try {
        # Stop the service if it's running
        Stop-Service -Name $serviceName -Force -ErrorAction Stop

        # Delete the service
        sc.exe delete $serviceName
    } catch {
        # Handle errors silently
    }
}




# User Cleanup
$usersToDelete = Get-LocalUser | Where-Object {$_.Name -like 'HEG_*'}

foreach ($user in $usersToDelete) {
        Remove-LocalUser -Name $user.Name        
}




# Staging Directory Cleanup
$directoryPath = ".\Staging"

# Get all items in the directory
$items = Get-ChildItem -Path $directoryPath

# Loop through each item and delete it
foreach ($item in $items) {
    try {
        Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
    } catch {
        # Handle errors silently
    }
}
