.DEFAULT_GOAL := help
SHELL=/bin/bash

# Configuration
# ¯¯¯¯¯¯¯¯¯¯¯¯¯

BASH_CONTAINER=php
export USER_UID=$(shell id -u)

ifdef FORTRESS_HOST
  DC_DIR=infra/fortress
else
  DC_DIR=infra/dev
  DC_PREFIX=sylius
endif

ifndef DC_PREFIX
  $(error Please define DC_PREFIX before running make)
endif

SYMFONY_ENV=dev

### PROJECT
# ¯¯¯¯¯¯¯¯¯

coffee: ## Launch it, and take coffee ☕️
	${MAKE} infra-update
	mkdir -p apps/sylius
	${MAKE} composer-create-project
	cp -Rv dist/dev/.* apps/sylius
	${MAKE} SYMFONY_ENV=dev install
install: up clean-cache theme-install sylius-install ## Install the project (⚠ Reset database)
infra-update: ## Update the Docker infrastructure
	${MAKE} PULL_FROM=1 pull build up


include resources/makefiles/sylius.mk
include resources/makefiles/composer.mk
include resources/makefiles/test.mk
include resources/makefiles/theming.mk
include resources/makefiles/docker.mk
include resources/makefiles/help.mk
