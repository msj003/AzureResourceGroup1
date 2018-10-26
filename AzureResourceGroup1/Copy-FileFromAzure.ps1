<# Custom Script for Windows to install a file from Azure Storage using the staging folder created by the deployment script #>
param (
    [string]$artifactsLocation,
    [string]$artifactsLocationSasToken,
    [string]$folderName,
    [string]$fileToInstall
)

$source = $artifactsLocation + "\$folderName\$fileToInstall" + $artifactsLocationSasToken
$dest = "C:\WindowsAzure\$folderName"
New-Item -Path $dest -ItemType directory
Invoke-WebRequest $source -OutFile "$dest\$fileToInstall"

new-item c:\CGIDEPLOY -itemtype directory
$client=new-object System.Net.WebClient

$Client.Downloadfile("https://cgiautomation.blob.core.windows.net/scripts/BLOBDL.ps1","c:\CGIDEPLOY\BLOBDL.ps1")
powershell.exe -ExecutionPolicy Unrestricted -command c:\CGIDEPLOY\BLOBDL.ps1
