#!/bin/bash
set -euo pipefail

echo "=============================="
echo "Docker Build & Push Stage"
echo "=============================="

# Required env vars
: "${DOCKER_USER:?Missing DOCKER_USER}"
: "${DOCKER_PASS:?Missing DOCKER_PASS}"
: "${DOCKERHUB_USERNAME:?Missing DOCKERHUB_USERNAME}"
: "${BUILD_NUMBER:?Missing BUILD_NUMBER}"

FRONTEND_IMAGE="frontend-app"
BACKEND_IMAGE="backend-app"
IMAGE_TAG="v1.0.${BUILD_NUMBER}"

echo "Logging into DockerHub"
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "Building Docker images"

docker build -t $DOCKERHUB_USERNAME/$FRONTEND_IMAGE:$IMAGE_TAG frontend
docker build -t $DOCKERHUB_USERNAME/$BACKEND_IMAGE:$IMAGE_TAG backend

echo "Running Trivy security scan"

trivy image --exit-code 1 --severity CRITICAL,HIGH \
  $DOCKERHUB_USERNAME/$FRONTEND_IMAGE:$IMAGE_TAG

trivy image --exit-code 1 --severity CRITICAL,HIGH \
  $DOCKERHUB_USERNAME/$BACKEND_IMAGE:$IMAGE_TAG

echo "Pushing images to DockerHub"

docker push $DOCKERHUB_USERNAME/$FRONTEND_IMAGE:$IMAGE_TAG
docker push $DOCKERHUB_USERNAME/$BACKEND_IMAGE:$IMAGE_TAG

echo "Docker images pushed successfully"
