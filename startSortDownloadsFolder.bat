@echo off
set ThisScriptsDir=%~dp0
set PowerShellScriptPath=%ThisScriptsDir%SortDownloadsFolder.ps1
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
PowerShell.exe -ExecutionPolicy Unrestricted -command "&'%PowerShellScriptPath%'"