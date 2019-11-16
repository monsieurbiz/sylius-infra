.DEFAULT_GOAL := help
SHELL=/bin/bash

# Configuration
# ¯¯¯¯¯¯¯¯¯¯¯¯¯

SYLIUS_FOLDER=sylius
PHP_VERSION=7.3
DOMAINS=apps/${SYLIUS_FOLDER}:sylius-store
SYLIUS_FIXTURES_SUITE=default

BASH_CONTAINER=php
export USER_UID=$(shell id -u)

DC_DIR=infra/dev
DC_PREFIX=sylius
APP_ENV=dev

ifndef DC_PREFIX
  $(error Please define DC_PREFIX before running make)
endif


### QUICK
# ¯¯¯¯¯¯¯

up start: docker.up symfony.proxy.start symfony.server.start ## Up

down: docker.down symfony.proxy.stop symfony.server.stop ## Down

stop: docker.stop symfony.proxy.stop symfony.server.stop ## Stop

logs: docker.logs symfony.server.log ## Logs


### PROJECT
# ¯¯¯¯¯¯¯¯¯

coffee: ## Launch it, and take coffee ☕️
	${MAKE} project.infra.update
	mkdir -p apps/${SYLIUS_FOLDER}
	rm -f .php-version
	echo "${PHP_VERSION}" > .php-version
	${MAKE} composer.create-project
	mv .php-version  apps/${SYLIUS_FOLDER}/
	${MAKE} apply-dist
	${MAKE} SYMFONY_ENV=dev project.install

project.install: docker.up app.start composer.install sylius.install theme.assets.install theme.install ## Install the project (⚠ Reset database)
project.infra.update: ## Update the Docker infrastructure
	${MAKE} PULL_FROM=1 docker.pull docker.build docker.up
apply-dist: ## Copy dist files
	mkdir -p apps/${SYLIUS_FOLDER}
	cp -Rv dist/dev/.env* apps/${SYLIUS_FOLDER}
	cp -Rv dist/dev/* apps/${SYLIUS_FOLDER}
add-symfony-bin: ## Download Symfony Binary
	curl -sS https://get.symfony.com/cli/installer | bash

include resources/makefiles/application.mk
include resources/makefiles/symfony.mk
include resources/makefiles/sylius.mk
include resources/makefiles/theming.mk
include resources/makefiles/composer.mk
include resources/makefiles/test.mk
include resources/makefiles/docker.mk
include resources/makefiles/help.mk
