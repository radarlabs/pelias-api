DOCKER_IMAGE ?= pelias-api
CIRCLE_SHA1 ?= $(shell git rev-parse HEAD)
SANITIZED_CIRCLE_BRANCH?=$(shell echo ${CIRCLE_BRANCH} | tr / _)

.DEFAULT_GOAL := help
help: ## Show Makefile usage and help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker-build: ## Build the docker image locally
	echo ${CIRCLE_BRANCH} | tr / _
	echo "Building: $(DOCKER_IMAGE):$(SANITIZED_CIRCLE_BRANCH)-$(CIRCLE_SHA1)"
	docker build \
		-f ./Dockerfile \
		-t "$(DOCKER_IMAGE):$(SANITIZED_CIRCLE_BRANCH)-$(CIRCLE_SHA1)" \
		-t "${DOCKER_REPOSITORY}:$(SANITIZED_CIRCLE_BRANCH)-${CIRCLE_SHA1}" \
		.

docker-push: ## Push local docker image to ECR
	DOCKER_REPOSITORY=${DOCKER_REPOSITORY} \
	CIRCLE_SHA1=${CIRCLE_SHA1} \
	CIRCLE_BRANCH=${SANITIZED_CIRCLE_BRANCH} \
	./ci/docker-push.sh
