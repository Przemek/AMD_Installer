@echo off

set _fileName=%1
set _fileExtension=.tar.xz

::list of miners by IP
set _minerIp[1]=192.168.88.137

set _user=user
set _password=miner1
set _puttyPath=C:\Program Files\PuTTY\
set _driverFilesPath=amd_drivers\
set _upgradeScriptName=amd_install.sh
set _homePath=/home/user/
set _workspaceDirName=tmp_workspace

set _prepareWorkspaceCommand=mkdir %_homePath%%_workspaceDirName%
set _executeScriptCommand=cd %_homePath%%_workspaceDirName%; chmod +x ./%_upgradeScriptName%; ./%_upgradeScriptName% %_fileName% %_fileExtension%
set _cleanupCommand=cd %_homePath%; rm -dr %_workspaceDirName%

set idx=1

:loop
call set minerIP=%%_minerIp[%idx%]%%
call set logFile=log_%minerIP%

call getTimestamp.bat & echo Updating AMD driver for: %minerIP%
call getTimestamp.bat & echo Transferring files...
"%_puttyPath%plink.exe" -batch -l %_user% -pw %_password% %minerIp% %_prepareWorkspaceCommand% >> %logFile% 2>&1
"%_puttyPath%pscp.exe" -P 22 -batch -scp -pw %_password% %_driverFilesPath%%_fileName%%_fileExtension% %_user%@%minerIp%:%_homePath%%_workspaceDirName%
"%_puttyPath%pscp.exe" -P 22 -batch -scp -pw %_password% %_upgradeScriptName% %_user%@%minerIp%:%_homePath%%_workspaceDirName%

call getTimestamp.bat & echo Executing script...
"%_puttyPath%plink.exe" -batch -l %_user% -pw %_password% %minerIp% %_executeScriptCommand% >> %logFile% 2>&1
"%_puttyPath%plink.exe" -batch -l %_user% -pw %_password% %minerIp% %_cleanupCommand% >> %logFile% 2>&1

call getTimestamp.bat & echo Update finished


set /a idx+=1	
if defined _minerIp[%idx%] goto :loop

call getTimestamp.bat & echo Finished updating all miners