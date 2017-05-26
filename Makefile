VERSION ?= "latest"
BASEIMAGE := "baseimage"
PHP := "php-5.6"
NODEJS := "nodejs-6"
TRAVIS_TAG ?= ""

build:
	IMAGE=$(BASEIMAGE) VERSION=$(VERSION) ./scripts/build.baseimage.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./scripts/build.image.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./scripts/build.image.sh

test:
	IMAGE=$(BASEIMAGE) VERSION=$(VERSION) ./scripts/test-runner.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./scripts/test-runner.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./scripts/test-runner.sh

publish:
	IMAGE=$(BASEIMAGE) VERSION="fat" ./scripts/publish.image.sh
	IMAGE=$(BASEIMAGE) VERSION=$(VERSION) ./scripts/publish.image.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./scripts/publish.image.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./scripts/publish.image.sh

.PHONY: build test publish
