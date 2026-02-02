#!/bin/bash
set -euo pipefail

echo "=============================="
echo "Starting Test Stage"
echo "=============================="

TEST_FAILED=false

echo "Running FRONTEND tests"
cd frontend
if npm test -- --watch=false; then
  echo "Frontend tests passed"
else
  echo "Frontend tests failed"
  TEST_FAILED=true
fi
cd ..

echo "Running BACKEND tests"
cd backend
if npm test; then
  echo "Backend tests passed"
else
  echo "Backend tests failed"
  TEST_FAILED=true
fi
cd ..

if [ "$TEST_FAILED" = true ]; then
  echo "One or more test suites failed"
  exit 1
fi

echo "All tests passed successfully"
