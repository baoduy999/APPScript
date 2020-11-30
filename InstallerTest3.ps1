<#
This script performs the installation of application list as table below.
Script Author = 'DXC Vietnam Offshore - Hong Ngo'
##*===============================================
##* INSTALLATION HISTORY WITH APP DETAILS
##*===============================================

[Number] |[Date]    |[AppName]              |[AppVersion]           |[AppArch] |[AppScriptVersion] |[AppRevision]   |[Comment]       
1        |1/12/2020 |Google Chrome          |83.0.4103.97           |x64       |1.0.0              |1.0             |
	

#>
##*===============================================
##* VARIABLE DECLARATION
##*===============================================

$connectTestResult= Test-NetConnection -ComputerName storageaccountabctesting.file.core.windows.net -Port 445
[string]$accountStorage="cmdkey /add:`"storageaccountabctesting.file.core.windows.net`" /user:`"Azure\storageaccountabctesting`" /pass:`"fKht8Qa8cYQAydD5/qx+vm2P9pX7eODYTpGJy3oEk0xxffkRELF48SiOshp8upXkvExewzIuJZIZubHSVRVpSw==`""
[string]$rootStrorageDirection="\\storageaccountabctesting.file.core.windows.net\installers"

[string]$systemVMDirection="C:\"

[string]$folderArchiveName1="GoogleChromeStandaloneEnterprise64.Zip"
[string]$folderArchiveDirection1="Z:\$folderArchiveName1"
[string]$folderName1="GoogleChromeStandaloneEnterprise64"
[string]$fileExecuteName1="Deploy-Application.exe"
[string]$FilePath1="$systemVMDirection\$folderName1\$fileExecuteName1"

##*===============================================


if ($connectTestResult.TcpTestSucceeded) {

# Save the password so the drive will persist on reboot
cmd.exe /C $accountStorage

# Mount the drive
if (Get-PSDrive Z -ErrorAction SilentlyContinue) {
    Write-Host 'The Z: drive is already created.'
    Expand-Archive -LiteralPath $folderArchiveDirection1 -DestinationPath $systemVMDirection
    Start-Process -FilePath $FilePath1 -Verb runAs

} else {
    New-PSDrive -Name Z -PSProvider FileSystem -Root $rootStrorageDirection -Persist
    Start-Sleep -s 20
    Expand-Archive -LiteralPath $folderArchiveDirection1 -DestinationPath $systemVMDirection
    Start-Process -FilePath $FilePath1 -Verb runAs
}
} else {
Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}