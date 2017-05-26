#!/usr/bin/env bash
set -eo pipefail

MOUNT=${PWD}/scripts
TEST="/scripts/test.${TEST}.sh"
IMAGE_DIET="dalee/${IMAGE}:${VERSION}"

function cleanup()
{
	echo "==> Stopping container.."
	docker stop ${CONTAINER_ID} >/dev/null
	docker rm ${CONTAINER_ID} >/dev/null
}
trap cleanup EXIT

echo "==> Starting image: ${IMAGE_DIET}"
CONTAINER_ID=$(docker run -d -v ${MOUNT}:/scripts ${IMAGE_DIET} /sbin/my_init)
sleep 3

echo "==> Start test script: ${TEST}"
docker exec -it ${CONTAINER_ID} /scripts/test.sh

