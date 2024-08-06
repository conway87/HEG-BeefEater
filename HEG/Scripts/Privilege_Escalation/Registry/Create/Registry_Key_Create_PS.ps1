New-Item -Path HKCU:\Console\HEG_Registry-Key-PS -Force
New-ItemProperty -Path HKCU:\Console\HEG_Registry-Key-PS -Name HEG -Value "HEG" -PropertyType String -Force
