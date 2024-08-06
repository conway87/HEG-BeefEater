Stop-Service -Name "HEG_Service-PS"
$service = Get-WmiObject -Class Win32_Service -Filter "Name='HEG_Service-PS'"
$service.Delete()