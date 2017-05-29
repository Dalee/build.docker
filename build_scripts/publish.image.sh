#!/usr/bin/env bash
set -eo pipefail

if [[ -z "${DOCKER_LOGIN}" || -z "${DOCKER_PASSWORD}" ]]; then
    echo "No hub.docker.com credentials provided!"
    exit 1
fi

docker login -u="$DOCKER_LOGIN" -p="$DOCKER_PASSWORD"

IMAGE_VERSION="dalee/${IMAGE}:${VERSION}"
if [ ! -z "${TRAVIS_TAG}" ]; then
    # tagged version release
    IMAGE_RELEASE="dalee/${IMAGE}:${TRAVIS_TAG}"

    docker tag ${IMAGE_VERSION} ${IMAGE_RELEASE}
    docker push ${IMAGE_RELEASE}
else
    # latest version release
    docker push ${IMAGE_VERSION}
fi
