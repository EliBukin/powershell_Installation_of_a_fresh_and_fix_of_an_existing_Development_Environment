[console]::WindowWidth=160; [console]::WindowHeight=50; [console]::BufferWidth=[console]::WindowWidth
 
:prompt
@REM Prompts to figure out the tactic.
   set /p answer=Do u want to run the uninstaller first (Y/N)?
   if /i "%answer:~,1%" EQU "Y" goto uninstall
   if /i "%answer:~,1%" EQU "N" goto install
   echo Please use Y or N.
   goto prompt	
   
:uninstall
@REM Starts the PS with elevated privledges, and sets execpol to unrestricted for the current process.
powershell.exe -executionpolicy unrestricted -noprofile -command "&{start-process powershell -ArgumentList '-NoExit -noprofile -file \"%UserProfile%\Desktop\AUtoPAck-v2.5\PS\UninstallScriptV2.5.ps1"' -verb RunAs}"


:install
@REM Starts the PS with elevated privledges, and sets execpol to unrestricted for the current process.
powershell.exe -executionpolicy unrestricted -noprofile -command "&{start-process powershell -ArgumentList '-NoExit -noprofile -file \"%UserProfile%\Desktop\AUtoPAck-v2.5\PS\Complete Automated Installation of Development EnvironmentV2.5.ps1\"' -verb RunAs}"


