New-Item -Path "c:\" -Name "MediaUnzipped" -ItemType "directory"
New-Item -Path "c:\" -Name "GeneratedMedia" -ItemType "directory"
New-Item -Path "c:\" -Name "MediaUnzipped" -ItemType "directory"
New-Item -Path "c:\" -Name "temp" -ItemType "directory"
Invoke-WebRequest https://github.com/Azure/azure-powershell/releases/download/v5.1.0-November2020/Az-Cmdlets-5.1.0.33698-x64.msi -OutFile C:\temp\Az-Cmdlets-5.1.0.33698-x64.msi
Start-Process C:\temp\Az-Cmdlets-5.1.0.33698-x64.msi -ArgumentList '/quiet'