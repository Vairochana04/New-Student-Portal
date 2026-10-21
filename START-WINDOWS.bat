@echo off
REM =========================================================
REM  New Student Portal - Windows one-click starter
REM =========================================================
title New Student Portal

cd /d "%~dp0"

echo.
echo ========================================================
echo   New Student Portal
echo ========================================================
echo.

where node >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Node.js not found.
    echo Install Node.js from https://nodejs.org (LTS), then run this again.
    pause
    exit /b 1
)

if not exist node_modules (
    echo [1/3] Installing dependencies (npm install)...
    call npm install
    if errorlevel 1 (
        echo [ERROR] npm install failed.
        pause
        exit /b 1
    )
) else (
    echo [1/3] node_modules already present, skipping npm install.
)

echo.
echo [2/3] Starting backend API on port 8092...
start "Backend API (port 8092)" cmd /k "npm run backend"

echo Waiting 5 seconds for backend to come up...
timeout /t 5 /nobreak >nul

echo.
echo [3/3] Starting frontend dev server on port 5173...
start "Frontend (port 5173)" cmd /k "npm run dev"

timeout /t 3 /nobreak >nul

echo.
echo ========================================================
echo   Both servers are starting.
echo   A browser window should open automatically; if not:
echo.
echo       http://localhost:5173
echo.
echo   Demo login:
echo       Email:     student@demo.edu
echo       Password:  student123
echo.
echo   To stop: close the two terminal windows or press
echo   Ctrl+C in each.
echo ========================================================
echo.

start http://localhost:5173
pause
