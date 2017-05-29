#!/usr/bin/env bash
set -eo pipefail

cleanup() {
    if [ ! -z "${CONTAINER_ID}" ]; then
        echo "==> Stopping container..."
        docker stop "${CONTAINER_ID}" >/dev/null
        docker rm "${CONTAINER_ID}" >/dev/null
    fi
}
trap cleanup EXIT

IMAGE_VERSION="dalee/${IMAGE}:test"
TESTCASE="testcase.${IMAGE}.sh"

echo "Building ${IMAGE_VERSION}"
IMAGE_ID=$(docker build --quiet -t "${IMAGE_VERSION}" . -f "./Dockerfile.${IMAGE}_test")

echo "==> Starting container: ${IMAGE_VERSION}..."
CONTAINER_ID=$(docker run -d -v ${PWD}/build_scripts:/build_scripts ${IMAGE_ID})
sleep 5

echo "==> Starting testcase: ${TESTCASE}..."
docker exec -it ${CONTAINER_ID} "/build_scripts/${TESTCASE}"
