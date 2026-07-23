#!/bin/bash
set -euo pipefail

# Environment variable validation
: "${GHCR_USER:?Variable GHCR_USER is not set}"
: "${GHCR_TOKEN:?Variable GHCR_TOKEN is not set}"

# Variable configuration
IMAGE_NAME="order-service"
TAG="latest"
REGISTRY="ghcr.io/ivanrafli14"

# Build image
echo ">>> Building image ${IMAGE_NAME}:${TAG} ..."
docker build -t "${IMAGE_NAME}:${TAG}" .

# Show local images
echo ">>> Local images:"
docker images

# Login to GHCR non-interactively
echo ">>> Logging in to GitHub Container Registry ..."
echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GHCR_USER}" --password-stdin

# Tag image for registry
echo ">>> Tagging image ..."
docker tag "${IMAGE_NAME}:${TAG}" "${REGISTRY}/${IMAGE_NAME}:${TAG}"

# Push image to registry
echo ">>> Pushing image to ${REGISTRY} ..."
docker push "${REGISTRY}/${IMAGE_NAME}:${TAG}"

echo ">>> Done! Image successfully pushed."
