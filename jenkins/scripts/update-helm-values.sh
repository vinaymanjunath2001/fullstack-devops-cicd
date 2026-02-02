#!/bin/bash
set -euo pipefail

echo "=============================="
echo "Updating Helm values.yaml"
echo "=============================="

: "${BUILD_NUMBER:?Missing BUILD_NUMBER}"
: "${GIT_USERNAME:?Missing GIT_USERNAME}"
: "${GIT_EMAIL:?Missing GIT_EMAIL}"

IMAGE_TAG="v1.0.${BUILD_NUMBER}"
VALUES_FILE="helm/fullstack-app/values.yaml"

echo "Using image tag: $IMAGE_TAG"

# Configure git
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"

# Update frontend image tag
sed -i "s|tag: .*|tag: ${IMAGE_TAG}|g" $VALUES_FILE

# Verify change
echo "Updated values.yaml:"
grep "tag:" $VALUES_FILE

# Commit & push
git add $VALUES_FILE
git commit -m "ci: update image tag to ${IMAGE_TAG}"
git push origin main

echo "Helm values updated and pushed successfully"
