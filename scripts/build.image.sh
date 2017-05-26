#!/usr/bin/env bash
set -eo pipefail

IMAGE_DIET="dalee/${IMAGE}:${VERSION}"

docker build --squash -t ${IMAGE_DIET} . -f "./Dockerfile.${IMAGE}"
