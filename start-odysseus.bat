@echo off
setlocal enabledelayedexpansion
title Odysseus Launcher

echo ===================================================
echo               Starting Odysseus Stack               
echo ===================================================
echo.

cd /d "%~dp0"

:: 1. Check & Start Ollama
echo [1/3] Checking Ollama...
tasklist /FI "IMAGENAME eq ollama app.exe" 2>NUL | find /I /N "ollama app.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo     Ollama is already running.
) else (
    echo     Starting Ollama...
    start "" "%LOCALAPPDATA%\Programs\Ollama\ollama app.exe"
    ping 127.0.0.1 -n 4 >nul
)

:: 2. Check & Start Docker Desktop
echo.
echo [2/3] Checking Docker Desktop...
docker info >nul 2>&1
if "%ERRORLEVEL%"=="0" (
    echo     Docker daemon is ready.
) else (
    echo     Starting Docker Desktop...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    echo     Waiting for Docker daemon to become ready...
    :wait_docker
    ping 127.0.0.1 -n 4 >nul
    docker info >nul 2>&1
    if not "%ERRORLEVEL%"=="0" (
        echo     Still waiting for Docker...
        goto wait_docker
    )
    echo     Docker is ready!
)

:: 3. Start Odysseus Containers
echo.
echo [3/3] Starting Odysseus containers...
docker compose up -d

echo.
echo ===================================================
echo     Odysseus is running at http://localhost:7000
echo ===================================================
echo.

:: Open in default browser
ping 127.0.0.1 -n 3 >nul
start http://localhost:7000
