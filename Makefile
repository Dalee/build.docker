VERSION ?= "latest"
PHP := "php-5.6"
NODEJS := "nodejs-6"

build:
	VERSION=$(VERSION) ./build_scripts/build.baseimage.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./build_scripts/build.image.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./build_scripts/build.image.sh

test:
	IMAGE="test" VERSION="test" ./build_scripts/build.image.sh

publish:
	IMAGE="baseimage" VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(PHP) VERSION=$(VERSION) ./build_scripts/publish.image.sh
	IMAGE=$(NODEJS) VERSION=$(VERSION) ./build_scripts/publish.image.sh

.PHONY: build publish
