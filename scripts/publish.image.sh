#!/usr/bin/env bash
set -eo pipefail

if [[ -z "${DOCKER_LOGIN}" || -z "${DOCKER_PASSWORD}" ]]; then
    echo "No hub.docker.com credentials provided!"
    exit 1
fi

docker login -u="$DOCKER_LOGIN" -p="$DOCKER_PASSWORD"

IMAGE_VERSION="dalee/${IMAGE}:${VERSION}"
docker push ${IMAGE_VERSION}

if [ ! -z "${TRAVIS_TAG}" ]; then
    IMAGE_RELEASE="dalee/${IMAGE}:${TRAVIS_TAG}"
    docker tag ${IMAGE_VERSION} ${IMAGE_RELEASE}
    docker push ${IMAGE_RELEASE}
fi
