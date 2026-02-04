#!/bin/bash
set -e

echo "=============================="
echo "Docker Push Stage"
echo "=============================="

# Docker config for Jenkins user
mkdir -p /var/lib/jenkins/.docker
export DOCKER_CONFIG=/var/lib/jenkins/.docker

echo "Logging in to DockerHub..."
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "Pushing FRONTEND image..."
docker push "$DOCKERHUB_USERNAME/$FRONTEND_IMAGE:$IMAGE_TAG"

echo "Pushing BACKEND image..."
docker push "$DOCKERHUB_USERNAME/$BACKEND_IMAGE:$IMAGE_TAG"

echo "Logging out from DockerHub..."
docker logout

echo "Docker images pushed successfully"
