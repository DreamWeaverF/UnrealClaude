@echo off
setlocal

set "ROOT=%~dp0.."
set "SOURCE=%ROOT%\gitRelease\Binaries"
set "TARGET=%ROOT%\Binaries"

if not exist "%SOURCE%" (
    echo Missing %SOURCE%
    echo Put release binaries under gitRelease\Binaries before running this script.
    exit /b 1
)

if not exist "%TARGET%" mkdir "%TARGET%"
xcopy "%SOURCE%" "%TARGET%" /E /I /Y >nul
if errorlevel 1 exit /b %ERRORLEVEL%

echo Binaries restored to %TARGET%
