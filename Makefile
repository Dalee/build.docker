VERSION ?= "latest"
BASEIMAGE := "baseimage"
PHP56 := "php-5.6"
PHP7 := "php-7.1"
PHP72 := "php-7.2"
NODEJS6 := "nodejs-6"
NODEJS8 := "nodejs-8"

build:
	IMAGE="baseimage" VERSION=$(VERSION) ./build_scripts/build.diet-image.sh
	IMAGE=$(PHP56) VERSION=$(VERSION) ./build_scripts/build.image.sh
	IMAGE=$(PHP7) VERSION=$(VERSION) ./build_scripts/build.image.sh
	IMAGE=$(PHP72) VERSION=$(VERSION) ./build_scripts/build.image.sh
	IMAGE=$(NODEJS6) VERSION=$(VERSION) ./build_scripts/build.image.sh
	IMAGE=$(NODEJS8) VERSION=$(VERSION) ./build_scripts/build.image.sh

test:
	IMAGE="baseimage" ./build_scripts/test.image.sh

publish:
	IMAGE="baseimage" VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(PHP56) VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(PHP7) VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(PHP72) VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(NODEJS6) VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(NODEJS8) VERSION=$(VERSION) ./build_scripts/publish.image.sh

.PHONY: build test publish
