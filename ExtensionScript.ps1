New-Item -Path "c:\" -Name "MediaUnzipped" -ItemType "directory"
New-Item -Path "c:\" -Name "GeneratedMedia" -ItemType "directory"
New-Item -Path "c:\" -Name "MediaUnzipped" -ItemType "directory"
New-Item -Path "c:\" -Name "temp" -ItemType "directory"
Invoke-WebRequest https://github.com/Azure/azure-powershell/releases/download/v5.1.0-November2020/Az-Cmdlets-5.1.0.33698-x64.msi -OutFile C:\temp\Az-Cmdlets-5.1.0.33698-x64.msi
Start-Process C:\temp\Az-Cmdlets-5.1.0.33698-x64.msi -ArgumentList '/quiet'

$computer = "AAP-vm"



$result = winrm id -r:$computer 2> $null

if ($lastExitCode -eq 0) {
    Write-Host "WinRM already enabled on" $computer "..." -ForegroundColor green
} else {
    Write-Host "Enabling WinRM on" $computer "..." -ForegroundColor red 
    .\psexec.exe \\$computer -s C:\Windows\System32\winrm.cmd qc -quiet

        if ($LastExitCode -eq 0) {
            .\pstools\psservice.exe \\$computer restart WinRM
            $result  = winrm id -r:$computer 2>$null

            if ($LastExitCode -eq 0) {Write-Host "WinRM successfully enabled!" -ForegroundColor green}
            else {exit 1}

       } #end of if

    } #end of else  
    #end of foreach
