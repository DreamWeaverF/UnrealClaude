@echo off
setlocal

set "ROOT=%~dp0.."
set "TARGET=%ROOT%\Binaries"
set "URL=%~1"
set "TEMP_DIR=%TEMP%\UnrealClaude-Binaries"
set "ZIP=%TEMP%\UnrealClaude-Binaries.zip"

if "%URL%"=="" (
    echo Usage: %~nx0 ^<github-release-binaries-zip-url^>
    echo The zip must contain a Binaries folder at its root.
    exit /b 1
)

where powershell >nul 2>nul
if errorlevel 1 (
    echo PowerShell is required to download release binaries.
    exit /b 1
)

if exist "%TEMP_DIR%" rmdir /S /Q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIP%'; Expand-Archive -Force '%ZIP%' '%TEMP_DIR%'"
if errorlevel 1 exit /b %ERRORLEVEL%

if exist "%TEMP_DIR%\Binaries" (
    if not exist "%TARGET%" mkdir "%TARGET%"
    xcopy "%TEMP_DIR%\Binaries" "%TARGET%" /E /I /Y >nul
) else if exist "%TEMP_DIR%\Win64" (
    if not exist "%TARGET%" mkdir "%TARGET%"
    xcopy "%TEMP_DIR%" "%TARGET%" /E /I /Y >nul
) else (
    echo Downloaded package must contain Binaries\ or Win64\.
    exit /b 1
)

if errorlevel 1 exit /b %ERRORLEVEL%
echo Binaries restored to %TARGET%
