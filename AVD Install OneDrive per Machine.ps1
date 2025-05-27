# Define the URL of the OneDriveSetup.exe file
$OneDriveSetupUrl = "https://go.microsoft.com/fwlink/?linkid=844652"

# Define the path where the OneDriveSetup.exe file will be downloaded
$DownloadPath = "C:\Temp\OneDriveSetup.exe"

# Create the directory if it doesn't exist
if (!(Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp"
}

# Download the OneDriveSetup.exe file
Invoke-WebRequest -Uri $OneDriveSetupUrl -OutFile $DownloadPath

# Run this command from an elevated command prompt to set the AllUsersInstall registry value
REG ADD "HKLM\Software\Microsoft\OneDrive" /v "AllUsersInstall" /t REG_DWORD /d 1 /reg:64

# Execute the OneDriveSetup.exe file with the /allusers flag
Start-Process -FilePath $DownloadPath -ArgumentList "/allusers" -Wait

# Run this command to configure OneDrive to start at sign in for all users
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "C:\Program Files\Microsoft OneDrive\OneDrive.exe /background" /f

# Enable Silently configure user account by running the following command
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "SilentAccountConfig" /t REG_DWORD /d 1 /f

# Redirect and move Windows known folders to OneDrive by running the following command.
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v "KFMSilentOptIn" /t REG_SZ /d "703cd1ec-08da-462d-9517-8203ec2c2732" /f

