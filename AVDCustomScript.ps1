#Set FSLogix
New-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "VHDLocations" -Value "\\stbwavdprof01.file.core.windows.net\avdprofiles\fslogix" -PropertyType MultiString -Force
Set-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "ProfileType" -Type "Dword" -Value "0" -Force
Remove-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "SIDDirNamePattern" -Force
Remove-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "SIDDirNameMatch" -Force
Remove-ItemProperty -Path HKLM:\SOFTWARE\FSLogix\Profiles -Name "CCDLocations"

#Set AU
Set-WinSystemLocale en-AU
Set-Culture -CultureInfo en-AU
Set-WinHomeLocation -GeoId 12
Set-TimeZone -Name "W. Australia Standard Time"
$list = New-WinUserLanguageList en-AU
$list[0].Handwriting = $true
Set-WinUserLanguageList $list -Force
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

### End Script ###
