# New Student Portal - VS Code / PowerShell starter
Set-Location $PSScriptRoot
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  New Student Portal" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Node.js not found. Install it from https://nodejs.org" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

if (-not (Test-Path "node_modules")) {
    Write-Host "[1/3] Installing dependencies..." -ForegroundColor Yellow
    npm install
} else {
    Write-Host "[1/3] node_modules already present." -ForegroundColor Green
}

Write-Host ""
Write-Host "[2/3] Launching backend in a new window..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$PSScriptRoot'; npm run backend"

Start-Sleep -Seconds 5

Write-Host "[3/3] Launching frontend in a new window..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location '$PSScriptRoot'; npm run dev"

Start-Sleep -Seconds 3
Start-Process "http://localhost:5173"

Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "  Servers are starting. Browser should open at:" -ForegroundColor Green
Write-Host "    http://localhost:5173" -ForegroundColor White
Write-Host "  Demo login: student@demo.edu / student123" -ForegroundColor White
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to close this window (servers keep running)"
