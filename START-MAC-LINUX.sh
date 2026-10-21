#!/usr/bin/env bash
# =========================================================
#  New Student Portal - Mac / Linux one-click starter
# =========================================================
set -e
cd "$(dirname "$0")"

echo
echo "========================================================"
echo "  New Student Portal"
echo "========================================================"
echo

if ! command -v node >/dev/null 2>&1; then
  echo "[ERROR] Node.js not found. Install from https://nodejs.org (LTS) and try again."
  exit 1
fi

if [ ! -d node_modules ]; then
  echo "[1/3] Installing dependencies (npm install)..."
  npm install
else
  echo "[1/3] node_modules already present, skipping npm install."
fi

echo
echo "[2/3] Starting backend API on port 8092..."
( npm run backend ) >/tmp/portal-backend.log 2>&1 &
BACK_PID=$!
echo "  backend PID: $BACK_PID"

echo "Waiting 5 seconds for backend to come up..."
sleep 5

echo
echo "[3/3] Starting frontend dev server..."
echo
echo "========================================================"
echo "  Open http://localhost:5173 in your browser."
echo "  Demo login:"
echo "    Email:     student@demo.edu"
echo "    Password:  student123"
echo
echo "  Press Ctrl+C here to stop both servers."
echo "========================================================"
echo

cleanup() {
  echo
  echo "Stopping servers..."
  kill $BACK_PID 2>/dev/null || true
  pkill -f "vite" 2>/dev/null || true
  exit 0
}
trap cleanup INT TERM

npm run dev
cleanup
