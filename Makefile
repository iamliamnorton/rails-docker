PROJECT           = rails
TAG              ?= dev

IMAGE = $(PROJECT):$(TAG)

.PHONY: build
build:
	docker build --rm -t $(IMAGE) .

.PHONY: test
test:
	docker run --rm -t $(IMAGE) true

.PHONY: shell
shell:
	docker run --rm -it --privileged $(IMAGE) bash

