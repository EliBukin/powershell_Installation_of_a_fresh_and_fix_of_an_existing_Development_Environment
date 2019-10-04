#Starts the PS window in a specific size.
[console]::WindowWidth=160; [console]::WindowHeight=50; [console]::BufferWidth=[console]::WindowWidth

#Uninstall script.

Write-Host "
 _______ _     _ _______  _____  _______ _______ _______ _______ ______ 
 |_____| |     |    |    |     | |  |  | |_____|    |    |______ |     \
 |     | |_____|    |    |_____| |  |  | |     |    |    |______ |_____/
                                                                        
 _______  _____  _______ _______ _  _  _ _______  ______ _______
 |______ |     | |______    |    |  |  | |_____| |_____/ |______
 ______| |_____| |          |    |__|__| |     | |    \_ |______
                                                                
  ______ _______ _______  _____  _    _ _______             ______  __   __
 |_____/ |______ |  |  | |     |  \  /  |_____| |           |_____]   \_/  
 |    \_ |______ |  |  | |_____|   \/   |     | |_____      |_____]    |   
                                                                           
 _____ ______  _____ _______
   |   |     \   |      |   
 __|__ |_____/ __|__    |   
                            
 ______  _______ _    _  _____   _____  _______
 |     \ |______  \  /  |     | |_____] |______
 |_____/ |______   \/   |_____| |       ______|
                                               
 _______ _______ _______ _______
    |    |______ |_____| |  |  |
    |    |______ |     | |  |  |

--/.-.//.../../-./../.../-/./.-.//-/...././/.-/..-/-/---/--/.-/-/---/.-.////

"        

write-Host "You are about to start software removal process, uninstall dialog boxes will pop up to prompt removal,
            
if you don't wanna remove the software just click Cancle."                        

#Uninstall all instances of JAVA using WMI, needed in rare cases.
$javauninstall = Read-Host "


What JAVA version would you like to remove, ALL, 7, 8 ?"

if ($javauninstall -eq "ALL") {Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -like "*java*"} | foreach-object -process {$_.Uninstall()} }

if ($javauninstall -eq 7) {gwmi Win32_Product -filter "name like 'Java%' AND vendor like 'Oracle%' AND (version like '7.%' OR version like '1.7.%')" | % { if (Get-Member -In $_ -Name "Uninstall" -Mem Method) { Write-Host "Uninstalling $($_.Name)"; $_.Uninstall().ReturnValue; } } }

if ($javauninstall -eq 8) {gwmi Win32_Product -filter "name like 'Java%' AND vendor like 'Oracle%' AND (version like '8.%' OR version like '1.8.%')" | % { if (Get-Member -In $_ -Name "Uninstall" -Mem Method) { Write-Host "Uninstalling $($_.Name)"; $_.Uninstall().ReturnValue; } } }

#Uninstall Java 8 only using WMI.
#gwmi Win32_Product -filter "name like 'Java%' AND vendor like 'Oracle%' AND (version like '8.%' OR version like '1.8.%')" | % { if (Get-Member -In $_ -Name "Uninstall" -Mem Method) { Write-Host "Uninstalling $($_.Name)"; $_.Uninstall().ReturnValue; } }

#uninstall NotePad++ using registry key.
$prog = Get-ChildItem -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* , HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -like "*notepad*" } |
            Select-Object -Property DisplayName, UninstallString

ForEach ($ver in $prog) {

    If ($ver.UninstallString) {

        $uninst = $ver.UninstallString
        & cmd /c $uninst /quiet /norestart
    }

}

#Uninstall Subversion using registry key.
$prog = Get-ChildItem -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* , HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* , HKCU:\Software\* |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -like "*subversion*" } |
            Select-Object -Property DisplayName, UninstallString

ForEach ($ver in $prog) {

    If ($ver.UninstallString) {

        $uninst = $ver.UninstallString
        & cmd /c $uninst /quiet /norestart
    }

}

#Uninstall Intellij using registry key.
$prog = Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -like "*intellij*" } |
            Select-Object -Property DisplayName, UninstallString

ForEach ($ver in $prog) {

    If ($ver.UninstallString) {

        $uninst = $ver.UninstallString
        & cmd /c $uninst /quiet /norestart
    }

}

#uninstall TortoiseSVN using registry key.
$prog = Get-ChildItem -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* , HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -like "*tortoise*" } |
            Select-Object -Property DisplayName, UninstallString

ForEach ($ver in $prog) {

    If ($ver.UninstallString) {

        $uninst = $ver.UninstallString
        & cmd /c $uninst /quiet /norestart
    }

}

Write-Host "
 _     _ __   _ _____ __   _ _______ _______ _______                     _____   ______  _____  _______ _______ _______ _______
 |     | | \  |   |   | \  | |______    |    |_____| |      |           |_____] |_____/ |     | |       |______ |______ |______
 |_____| |  \_| __|__ |  \_| ______|    |    |     | |_____ |_____      |       |    \_ |_____| |_____  |______ ______| ______|
                                                                                                                               
 _______  _____  _______  _____         _______ _______ _______
 |       |     | |  |  | |_____] |      |______    |    |______
 |_____  |_____| |  |  | |       |_____ |______    |    |______
 "                                                              
