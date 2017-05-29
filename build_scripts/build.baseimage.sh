#!/usr/bin/env bash
set -eo pipefail

IMAGE_FULL="dalee/baseimage:fat"
IMAGE_DIET="dalee/baseimage:${VERSION}"

echo "Building: ${IMAGE_FULL}"
docker build -t ${IMAGE_FULL} . -f "./Dockerfile.baseimage"

echo "Squashing: ${IMAGE_FULL}"
ID=$(docker run -d ${IMAGE_FULL} /bin/bash)

# discard everything from baseimage
docker export ${ID} | docker import - ${IMAGE_DIET} -m "(S): ${IMAGE_FULL} => ${IMAGE_DIET}"
docker stop ${ID} && docker rm ${ID}
