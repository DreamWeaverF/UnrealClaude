@echo off
setlocal

where node >nul 2>nul
if not errorlevel 1 (
    node -e "const major=Number(process.versions.node.split('.')[0]); process.exit(major >= 18 ? 0 : 1)" >nul 2>nul
    if not errorlevel 1 (
        echo Node.js 18+ is already installed.
        exit /b 0
    )
)

where winget >nul 2>nul
if errorlevel 1 (
    echo Node.js 18+ is required, but winget was not found.
    echo Install Node.js 18+ manually, then run this script again.
    exit /b 1
)

winget install -e --id OpenJS.NodeJS.LTS
if errorlevel 1 exit /b %ERRORLEVEL%

node -e "const major=Number(process.versions.node.split('.')[0]); process.exit(major >= 18 ? 0 : 1)" >nul 2>nul
if errorlevel 1 (
    echo Node.js was installed, but this shell cannot see Node.js 18+ yet.
    echo Open a new terminal and run this script again.
    exit /b 1
)

echo Node.js 18+ is ready.
