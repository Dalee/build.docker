#!/usr/bin/env bash
set -eo pipefail

IMAGE_DIET="dalee/${IMAGE}:${VERSION}"

echo "Building image: ${IMAGE_DIET}"
docker build -t ${IMAGE_DIET} . -f "./Dockerfile.${IMAGE}"
