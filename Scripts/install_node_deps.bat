@echo off
setlocal

set "ROOT=%~dp0.."
set "BRIDGE=%ROOT%\Resources\mcp-bridge"

where node >nul 2>nul
if errorlevel 1 (
    echo Node.js 18+ is required.
    where winget >nul 2>nul
    if errorlevel 1 (
        echo Install Node.js 18+ first, then run this script again.
        exit /b 1
    )
    winget install -e --id OpenJS.NodeJS.LTS
)

node -e "const major=Number(process.versions.node.split('.')[0]); process.exit(major >= 18 ? 0 : 1)" >nul 2>nul
if errorlevel 1 (
    echo Node.js 18+ is required. Please upgrade Node.js and run this script again.
    exit /b 1
)

if not exist "%BRIDGE%\package.json" (
    echo Missing %BRIDGE%\package.json
    exit /b 1
)

pushd "%BRIDGE%" >nul
if exist package-lock.json (
    call npm ci
) else (
    call npm install
)
set "RESULT=%ERRORLEVEL%"
popd >nul

exit /b %RESULT%
