# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM=20
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Initializes build/web/ as a clone of the [website-build] repository.
init-build:
	@ ./scripts/init_build.sh

## Reconfigures the production remote.
init-remote:
	@ ./scripts/init_remote.sh

## Re-initializes the repository and connects it to the remote.
init:
	@ make init-build
	@ make init-remote

## Pushes the latest build to the [website-build] repository.
publish:
	@ ./scripts/publish.sh

## Builds the project for the web platform.
build-web:
	@ flutter build web

## Builds the project and pushes it to the [website-build] repository.
build-and-publish:
	@ make build-web
	@ make publish


