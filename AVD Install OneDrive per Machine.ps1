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

# Registry values to add if they don't exist
$RegistryValues = @(
    @{
        Path = "HKLM:\Software\Microsoft\OneDrive"
        Name = "AllUsersInstall"
        Value = 1
        Type = "DWord"
    },
    @{
        Path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
        Name = "OneDrive"
        Value = "C:\Program Files\Microsoft OneDrive\OneDrive.exe /background"
        Type = "String"
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = "SilentAccountConfig"
        Value = 1
        Type = "DWord"
    },
    @{
        Path = "HKLM:\SOFTWARE\Policies\Microsoft\OneDrive"
        Name = "KFMSilentOptIn"
        Value = "703cd1ec-08da-462d-9517-8203ec2c2732"
        Type = "String"
    }
)

# Set registry values only if they don't exist
foreach ($reg in $RegistryValues) {
    if (-not (Test-Path $reg.Path)) {
        New-Item -Path $reg.Path -Force | Out-Null
    }

    $existingValue = Get-ItemProperty -Path $reg.Path -Name $reg.Name -ErrorAction SilentlyContinue
    if ($null -eq $existingValue) {
        Set-ItemProperty -Path $reg.Path -Name $reg.Name -Value $reg.Value -Type $reg.Type
    }
}

# Execute the OneDriveSetup.exe file with the /allusers flag
Start-Process -FilePath $DownloadPath -ArgumentList "/allusers" -Wait
