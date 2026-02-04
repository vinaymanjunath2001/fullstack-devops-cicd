#!/bin/bash
set -e

echo "=============================="
echo "Starting Build Stage"
echo "=============================="

# Jenkins npm cache
export NPM_CONFIG_CACHE=/var/lib/jenkins/.npm
mkdir -p "$NPM_CONFIG_CACHE"

#################################
# FRONTEND BUILD
#################################
echo "Building FRONTEND"
cd frontend

rm -rf node_modules || true

if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

npm run build
cd ..

#################################
# BACKEND BUILD
#################################
echo "Building BACKEND"
cd backend

rm -rf node_modules || true

if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

cd ..

echo "Build stage completed successfully"
