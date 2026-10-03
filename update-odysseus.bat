@echo off
title Update Odysseus

echo ===================================================
echo               Updating Odysseus Stack               
echo ===================================================
echo.

cd /d "%~dp0"

echo [1/4] Fetching latest changes from upstream repository...
git fetch upstream
if not "%ERRORLEVEL%"=="0" (
    echo Error fetching from upstream. Check your internet connection.
    pause
    exit /b 1
)

echo.
echo [2/4] Merging upstream updates into dev branch...
git merge upstream/dev --no-edit
if not "%ERRORLEVEL%"=="0" (
    echo Merge encountered conflicts. Please resolve them before proceeding.
    pause
    exit /b 1
)

echo.
echo [3/4] Backing up to your personal GitHub fork...
git push origin dev

echo.
echo [4/4] Rebuilding and updating Docker containers...
docker compose up -d --build

echo.
echo ===================================================
echo     Odysseus has been successfully updated!
echo     Open http://localhost:7000 in your browser.
echo ===================================================
pause
