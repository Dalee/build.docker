#!/usr/bin/env bash
set -eo pipefail

IMAGE_DIET="dalee/${IMAGE}:${VERSION}"

echo "Downloading image: ${IMAGE_DIET}"
docker pull ${IMAGE_DIET} || /bin/true

echo "Building image: ${IMAGE_DIET}"
docker build --squash -t ${IMAGE_DIET} . -f "./Dockerfile.${IMAGE}"
