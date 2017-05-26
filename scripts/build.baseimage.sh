#!/usr/bin/env bash
set -eo pipefail

IMAGE_FULL="dalee/${IMAGE}:fat"
IMAGE_DIET="dalee/${IMAGE}:${VERSION}"

echo "Downloading full image: ${IMAGE_FULL}"
docker pull ${IMAGE_FULL} || /bin/true

echo "Building: ${IMAGE_FULL}"
docker build -t ${IMAGE_FULL} . -f "./Dockerfile.${IMAGE}"

echo "Squashing: ${IMAGE_FULL}"
ID=$(docker run -d ${IMAGE_FULL} /bin/bash)

docker export ${ID} | docker import - ${IMAGE_DIET} -m "(S): ${IMAGE_FULL} => ${IMAGE_DIET}"
docker stop ${ID}
docker rm ${ID}
