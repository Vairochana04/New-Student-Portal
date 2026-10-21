@echo off
cd /d "%~dp0"
where npm >nul 2>nul || (echo Node.js / npm kandupudikala. Node.js LTS install panni marupadiyum try pannunga: https://nodejs.org & pause & exit /b 1)
if not exist node_modules\ (echo First time: dependencies install aagudhu... & call npm install)
start "Student Portal - Backend API 8092" cmd /k npm run backend
start "Student Portal - Website 5188" cmd /k npm run dev
timeout /t 5 /nobreak >nul
start http://localhost:5188
echo Portal start aayiduchu. Browser open aagala-naane: http://localhost:5188
