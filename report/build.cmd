@echo off
setlocal

set "PS_EXE=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

if not exist "%PS_EXE%" (
  echo PowerShell not found: %PS_EXE%
  exit /b 1
)

"%PS_EXE%" -ExecutionPolicy Bypass -File "%~dp0build.ps1"
exit /b %ERRORLEVEL%