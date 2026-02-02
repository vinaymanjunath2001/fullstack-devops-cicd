#!/bin/bash
set -euo pipefail

echo "=============================="
echo "Starting Build Stage"
echo "=============================="

echo "Building FRONTEND"
cd frontend

if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

npm run build
cd ..

echo "Building BACKEND"
cd backend

if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

cd ..

echo "Build completed successfully"
