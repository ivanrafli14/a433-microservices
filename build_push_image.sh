#!/bin/sh

# Build the application image with the local v1 tag.
docker build -t item-app:v1 .

# Show local images so the build result can be checked.
docker images

# Tag the local image for GitHub Container Registry.
docker tag item-app:v1 ghcr.io/ivanrafli14/item-app:v1

# Log in to GitHub Container Registry before pushing.
docker login ghcr.io

# Push the tagged image to GitHub Container Registry.
docker push ghcr.io/ivanrafli14/item-app:v1
