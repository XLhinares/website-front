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
## Checks whether the version number and the last changelog-ed version match.
check-version:
	@echo "\n>>> CHECKING VERSION:"
	@echo "To implement"

## Analyzes the contents of the lib folder.
analyze:
	@echo "\n>>> ANALYZING LIB/ CODE:"
	@flutter pub get
	@flutter analyze lib/

## Formats the code to match flutter's conventions
format:
	@echo "\n>>> FORMATTING PROJECT CODE:"
	@flutter format .

## Analyzes and format the code to make sure of the quality.
pre-commit:
	@echo "\n>>> RUNNING PRE-COMMIT CHECKS:"
	@make format
	@make analyze
	@make check-version

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

## Pushes the latest build to the [website-build] repository without acknowledging any change.
publish-without-changes:
	@ ./scripts/publish_without_changes.sh

## Builds the project for the web platform.
build-web:
	@ flutter build web

## Builds the project and pushes it to the [website-build] repository.
build-and-publish:
	@ make build-web
	@ make publish


