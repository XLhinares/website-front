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

## Re-initializes git in the build repository, connects it to the remote and publishes the current build.
connect:
	@ ./scripts/build_connect.sh

## Pushes the latest build to the [website-build] repository.
publish:
	@ ./scripts/build_publish.sh


## Builds the project for the web platform.
build:
	@ flutter build web



