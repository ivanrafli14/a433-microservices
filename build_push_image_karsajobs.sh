#!/bin/bash
set -euo pipefail

# Validasi environment variable yang dibutuhkan
: "${GHCR_USER:?Variable GHCR_USER tidak diset}"
: "${GHCR_TOKEN:?Variable GHCR_TOKEN tidak diset}"

# Variabel konfigurasi
IMAGE_NAME="karsajobs"
TAG="latest"
REGISTRY="ghcr.io/ivanrafli14"

# Build image
echo ">>> Building image ${IMAGE_NAME}:${TAG} ..."
docker build -t "${IMAGE_NAME}:${TAG}" .

# Tampilkan daftar image lokal
echo ">>> Local images:"
docker images

# Login ke GHCR secara non-interaktif
echo ">>> Logging in to GitHub Container Registry ..."
echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GHCR_USER}" --password-stdin

# Tag image untuk registry
echo ">>> Tagging image ..."
docker tag "${IMAGE_NAME}:${TAG}" "${REGISTRY}/${IMAGE_NAME}:${TAG}"

# Push image ke registry
echo ">>> Pushing image to ${REGISTRY} ..."
docker push "${REGISTRY}/${IMAGE_NAME}:${TAG}"

echo ">>> Done! Image successfully pushed."
