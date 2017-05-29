#!/usr/bin/env bash
set -eo pipefail

IMAGE_FULL="dalee/${IMAGE}:${VERSION}"

echo "Building image: ${IMAGE_FULL}"
docker build --squash -t ${IMAGE_FULL} . -f "./Dockerfile.${IMAGE}"
