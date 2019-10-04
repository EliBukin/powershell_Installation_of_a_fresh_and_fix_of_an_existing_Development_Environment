#Starts the PS window in a specific size.
[console]::WindowWidth=160; [console]::WindowHeight=50; [console]::BufferWidth=[console]::WindowWidth

<# Self-elevate the script if required
Here's how it works:
The first line checks to see if the script is already running in an elevated environment. This would occur if PowerShell is running as Administrator or UAC is disabled. If it is, the script will continue to run normally in that process.
The second line checks to see if the Windows operating system build number is 6000 (Windows Vista) or greater (Earlier builds did not support Run As elevation).
The third line retrieves the command line used to run the original script, including any arguments.
Finally, the fourth line starts a new elevated PowerShell process where the script runs again. Once the script terminates, the elevated PowerShell window closes.
#>
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

#Intro
Write-Host "
Complete Automated Installation of a Development Environment by:

1.618033988749894848204586834365638117720309179805762862135442 
_________ ______  __________________                         8
\__   __/(  __  \ \__   __/\__   __/                         6
   ) (   | (  \  )   ) (      ) (                            2
   | |   | |   ) |   | |      | |                            2
   | |   | |   | |   | |      | |                            7
   | |   | |   ) |   | |      | |                            0
___) (___| (__/  )___) (___   | |                            5
\_______/(______/ \_______/   )_(                            2
                                                             6
 ______   _______           _______  _______  _______        0
(  __  \ (  ____ \|\     /|(  ___  )(  ____ )(  ____ \       4
| (  \  )| (    \/| )   ( || (   ) || (    )|| (    \/       6
| |   ) || (__    | |   | || |   | || (____)|| (_____        2
| |   | ||  __)   ( (   ) )| |   | ||  _____)(_____  )       8
| |   ) || (       \ \_/ / | |   | || (            ) |       1
| (__/  )| (____/\  \   /  | (___) || )      /\____) |       8
(______/ (_______/   \_/   (_______)|/       \_______)       9
                                                             0
_________ _______  _______  _______                          2
\__   __/(  ____ \(  ___  )(       )                         4
   ) (   | (    \/| (   ) || () () |                         4
   | |   | (__    | (___) || || || |                         9
   | |   |  __)   |  ___  || |(_)| |                         7
   | |   | (      | (   ) || |   | |                         0
   | |   | (____/\| )   ( || )   ( |                         7
   )_(   (_______/|/     \||/     \|                         5
                                                             4
   --/.-.//.../../-./../.../-/./.-.//                        9
   -/...././/.-/..-/-/---/--/.-/-/---/.-.////                2
                                                             5
07204189391137484754088075386891752126633862223536931793180060
"                                                        

#Verifies the path to User Profile if it is located under ONEDRIVE.
$sapiensprofile = "$env:userprofile\one drive"
 
$normalprofile = "$env:userprofile"

 If (test-path $sapiensprofile)
                    {
                     $usrprflpath = "$sapiensprofile"
                    }

    else 
                    {
                     $usrprflpath = "$normalprofile"
                    }

Write-Host "The path to profile is $usrprflpath" 

#Prompts to install JAVA 7 or 8 in to specified directory (that is not the default ProgFiles), that loop will continue to prompt until 7 or 8 selected.
do {

$Q1 = Read-Host "what JAVA version would you like, 7 or 8 ?"

Write-Host "Now chill, it'll take a minute or two... or eight."

$javaver = $Q1

If ($javaver -eq 8 ) {cmd /c start /w $usrprflpath\Desktop\AUtoPAck-v2.5\Progs\jdk-8u112-windows-x64.exe /s ADDLOCAL="ToolsFeature,SourceFeature" INSTALLDIR=C:\software\java\jdk1.8.0_112 }

if ($javaver -eq 7 ) {cmd /c start /w $usrprflpath\Desktop\AUtoPAck-v2.5\Progs\jdk-7u79-windows-x64.exe /s ADDLOCAL="ToolsFeature,SourceFeature" INSTALLDIR=C:\software\java\jdk1.7.0_79 }

} 

until (($javaver -eq 7) -or ($javaver -eq 8)) 

#Install Tortoise SVN, this is a prepacked MSI installer that installs the software into C:\ProgramFiles.
Start-Process "$usrprflpath\Desktop\AUtoPAck-v2.5\Progs\TortoiseSVN-1.8.12.26648-dev-x64-ipv6-svn-1.8.14.msi" /q -Wait

#Checkes if the "C:\Program Files (x86)\Notepad++" directory exists, if not it installs NotePad, doesn't bitch about it if exists.
$NPpath = "C:\Program Files (x86)\Notepad++\notepad++.exe"
If(!(test-path $NPpath))
                    {
                     #Install the notepad++ in to specified directory (that is not the default ProgFiles).
                     cmd /c "$usrprflpath\Desktop\AUtoPAck-v2.5\Progs\npp.7.5.1.Installer.exe /S /D=C:\software\Notepad++"
                    }

#Install Subversion 1.8 in to specified directory.
cmd /c "$usrprflpath\Desktop\AUtoPAck-v2.5\Progs\CollabNetSubversion-client-1.8.13-1-x64.exe /S /D=C:\software\Subversion_Client"

#install ideaIC-14.1.5.exe in to specified directory.
cmd /c "$usrprflpath\Desktop\AUtoPAck-v2.5\Progs\ideaIC-14.1.5.exe /S /D=C:\software\IntelliJ IDEA Community Edition 14.1.5"

#Install JBOSS.
#Checkes if the "c:\jboss" directory exists, if not it creates it, doesn't bitch about it if exists.
$JBpath = "C:\jboss"
If(!(test-path $JBpath))
                    {
                     New-Item -ItemType Directory -Force -Path $JBpath
                    }
                    
#Copy Jboss 6.4 or 7.0 from AutoPack folder to c:\jboss
if ($javaver -eq 8) {Copy-Item $usrprflpath\Desktop\AUtoPAck-v2.5\Servers\Jboss\jboss-eap-7.0 c:\jboss\ -Recurse}

if ($javaver -eq 7) {Copy-Item $usrprflpath\Desktop\AUtoPAck-v2.5\Servers\Jboss\jboss-eap-6.4 c:\jboss\ -Recurse}

#Install Weblogic 1221 or 1213 with no domain configured.
if ($javaver -eq 8) {cmd /c "$usrprflpath\Desktop\AUtoPAck-v2.5\Servers\WebLogic\installWLS1221.bat"}

if ($javaver -eq 7) {cmd /c "$usrprflpath\Desktop\AUtoPAck-v2.5\Servers\WebLogic\installWLS1213.bat"}

Write-Host "                                     




                                            

 _____ __   _ _______ _______ _______               _______ _______ _____  _____  __   _      _______  _____  _______  _____         _______ _______ _______
   |   | \  | |______    |    |_____| |      |      |_____|    |      |   |     | | \  |      |       |     | |  |  | |_____] |      |______    |    |______
 __|__ |  \_| ______|    |    |     | |_____ |_____ |     |    |    __|__ |_____| |  \_|      |_____  |_____| |  |  | |       |_____ |______    |    |______
                                                                                                                                                            

                                                                                                           
"

