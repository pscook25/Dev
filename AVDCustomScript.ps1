#Set FSLogix
New-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "VHDLocations" -Value "\\stbwavdprof01.file.core.windows.net\avdprofiles\fslogix" -PropertyType MultiString -Force
New-ItemProperty -Path HKLM:\SOFTWARE\FSLogix\Profiles -Name "AccessNetworkAsComputerObject" -Value 1 -Force
Set-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "ProfileType" -Type "Dword" -Value "0" -Force
Remove-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "SIDDirNamePattern" -Force
Remove-ItemProperty -Path HKLM:\Software\FSLogix\Profiles -Name "SIDDirNameMatch" -Force
Remove-ItemProperty -Path HKLM:\SOFTWARE\FSLogix\Profiles -Name "CCDLocations" -Force


#Set Firewall
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Policies\Authentication" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Policies\Authentication" -Name "AllowedTlsAuthenticationEndpoints" -PropertyType MultiString -Value ('https://vmcauesca01.brightwatergroup.net/','https://vmcauesca02.brightwatergroup.net/') -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Policies\Authentication" -Name "ConfiguredTlsAuthenticationNetworkName" -PropertyType String -Value "BW" -Force


#Set AU
Set-WinSystemLocale en-AU
Set-Culture -CultureInfo en-AU
Set-WinHomeLocation -GeoId 12
Set-TimeZone -Name "W. Australia Standard Time"
$list = New-WinUserLanguageList en-AU
$list[0].Handwriting = $true
Set-WinUserLanguageList $list -Force
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True


#Set DNS
Set-DnsClientGlobalSetting -SuffixSearchList @("brightwatergroup.net", "brightwatergroup.com")


##Disabling web search on the start menu makes it so much faster and effective!
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Type DWord -Force

##Speed up File Explorer's slow folder scanning!
Set-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Name "FolderType" -Value "NotSpecified" -Type String -Force




