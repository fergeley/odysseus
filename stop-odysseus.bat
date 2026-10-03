@echo off
title Stop Odysseus

echo ===================================================
echo               Stopping Odysseus Stack               
echo ===================================================
echo.

cd /d "%~dp0"
docker compose stop

echo.
echo ===================================================
echo     Odysseus containers have been stopped.
echo ===================================================
pause
