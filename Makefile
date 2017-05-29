VERSION ?= "latest"
BASEIMAGE := "baseimage"
PHP := "php-5.6"
NODEJS := "nodejs-6"

build:
	IMAGE="baseimage" VERSION=$(VERSION) ./build_scripts/build.diet-image.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./build_scripts/build.image.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./build_scripts/build.image.sh

test:
	IMAGE="baseimage" ./build_scripts/test.image.sh

publish:
	IMAGE="baseimage" VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./build_scripts/publish.image.sh

.PHONY: build publish
