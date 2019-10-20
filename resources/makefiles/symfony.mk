### SYMFONY
# ¯¯¯¯¯¯¯¯¯

define symfony
	if [[ "$(2)" != "" ]]; \
	    then echo "(cd $(1) && symfony $(2))"; \
	    (cd $(1) && symfony $(2)); \
	else \
	    echo "(cd apps/${SYLIUS_FOLDER} && symfony $(1))"; \
	    (cd apps/${SYLIUS_FOLDER} && symfony $(1)); \
	fi;
endef

ifeq (${SYMFONY_USE_DOCKER_ONLY},1)
define symfony.console
	$(call docker-compose,exec --user www-data ${BASH_CONTAINER} bash -c "cd apps/${SYLIUS_FOLDER}/; ./bin/console $(1)")
endef
else
define symfony.console
	cd apps/${SYLIUS_FOLDER} && symfony console $(1)
endef
endif

ifeq (${SYMFONY_USE_DOCKER_ONLY},1)
define symfony.composer
	$(call docker-compose,exec --user www-data ${BASH_CONTAINER} bash -c "cd apps/${SYLIUS_FOLDER}/; composer $(1)")
endef
else
define symfony.composer
	cd apps/${SYLIUS_FOLDER} && symfony composer $(1)
endef
endif

symfony.domain.attach: ## Attach domains to symfony proxy
ifneq (${SYMFONY_USE_DOCKER_ONLY},1)
	@for domain in ${DOMAINS}; \
	do \
	    folder=`echo $$domain | cut -d: -f 1`;  \
	    host=`echo $$domain | cut -d: -f 2 | sed 's/,/ /g'`; \
	    $(call symfony,$$folder,local:proxy:domain:attach $$host) \
	done;
endif

symfony.server.start: ## Serve the app
ifneq (${SYMFONY_USE_DOCKER_ONLY},1)
ifeq (${SYMFONY_NO_TLS},1)
	@$(call symfony,serve --no-tls -d || true)
else
	@$(call symfony,serve -d || true)
endif
endif

symfony.server.stop: ## Serve the app
	@$(call symfony,local:server:stop || true)

symfony.server.restart: symfony.server.stop symfony.server.start ## Restart the app

symfony.server.log: ## Tail the logs
	@$(call symfony,local:server:log)

symfony.migration.generate: ## Generate migration file
	$(call symfony.console, doctrine:migrations:diff)

symfony.migration.execute: ## Excecute migration file
	$(call symfony.console, doctrine:migrations:execute ${ARGS})
