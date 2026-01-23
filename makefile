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
	@./scripts/check_version_number.sh

## Analyzes the contents of the lib folder.
analyze:
	@echo "\n>>> ANALYZING LIB/ CODE:"
	@flutter pub get
	@flutter analyze lib/

## Formats the code to match flutter's conventions
format:
	@echo "\n>>> FORMATTING PROJECT CODE:"
	@dart format .

## Analyzes and format the code to make sure of the quality.
pre-commit:
	@echo "\n>>> RUNNING PRE-COMMIT CHECKS:"
	@make format
	@make analyze
	@make check-version

## Runs the dev packages to make sure the platforms are properly set up. (useful when cloning the project from scratch)
initialize:
	@dart run package_rename
	@dart run flutter_launcher_icons
	@dart run flutter_native_splash:create

## Builds the project for the web platform.
compile:
	@echo "\n>>> REBUILDING THE PROJECT:"
	@make pre-commit
	@flutter clean
	@flutter pub get
	@make initialize
	@flutter build web

## Re-initializes git in the build repository, connects it to the remote and publishes the current build.
server_connect:
	@ ./scripts/build_connect.sh

## Pushes the latest build to the [website-build] repository.
server_publish:
	@ ./scripts/build_publish.sh

## Runs the flutter app and only shows the [DEBUG] and [ERROR] logs
run:
	@flutter run | awk -F': ' '{ \
		# Strip the "flutter (pid): " prefix \
		msg = gensub(/.*flutter \( *[0-9]+\): /, "", "g", $$0); \
		# Highlight brackets in yellow \
		msg = gensub(/\[([^\]]+)\]/, "\033[33m[\\1]\033[0m", "g", msg); \
		if ($$0 ~ /E\/flutter/) { \
			print "\033[31m[ERROR]\033[0m " msg; \
		} else if ($$0 ~ /I\/flutter/) { \
			print "\033[32m[INFO]\033[0m  " msg; \
		} else if ($$0 ~ /^[IWDE]\//) { \
        	# Drops lines starting with I/, W/, D/, or E/ that arent flutter-specific \
		} else { \
			print "\033[35m[OTHER]\033[0m  " msg; \
		} \
	}'


