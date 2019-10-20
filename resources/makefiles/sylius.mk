### SYLIUS
# ¯¯¯¯¯¯¯¯

sylius.install: sylius.db.refresh sylius.assets.install sylius.theme.assets.install ## Install Sylius

sylius.db.refresh: sylius.db.schema.reset sylius.fixtures.load ## Refresh Sylius database with fixtures (⚠ Reset database)

sylius.db.schema.reset: sylius.doctrine.cache.clear sylius.db.schema.reset.current sylius.db.schema.reset.test ## Reset database schema (⚠ Reset database)

sylius.db.schema.reset.current: ## Reset current database schema (⚠ Reset current database)
	$(call symfony.console,doctrine:database:drop --force --if-exists)
	$(call symfony.console,sylius:install:database -n)

sylius.db.schema.reset.test: ## Reset test database schema (⚠ Reset test database)
ifneq (${APP_ENV},fortress)
	$(call symfony.console,doctrine:database:drop --force --env=test --if-exists)
	$(call symfony.console,sylius:install:database -n --env=test)
endif

sylius.doctrine.cache.clear: ## Clear Doctrine's cache
	$(call symfony.console,doctrine:cache:clear-metadata || true)
	$(call symfony.console,doctrine:cache:clear-query || true)
	$(call symfony.console,doctrine:cache:clear-result || true)

sylius.fixtures.load: SUITE=${SYLIUS_FIXTURES_SUITE}
sylius.fixtures.load: ## Load Fixtures (use SUITE="" if you want to change the suite)
	$(call symfony.console,sylius:fixtures:load -n ${SUITE})

sylius.ckeditor.install: ## Install CKEditor
	$(call symfony.console,ckeditor:install -n)

sylius.assets.install: ## Install sylius assets
	$(call symfony.console,assets:install --symlink --relative public)
	$(call symfony.console,sylius:install:assets)

sylius.theme.assets.install: ## Install sylius themes assets
	$(call symfony.console,sylius:theme:assets:install --symlink --relative public)

sylius.warmup: ## Warmup the cache
	$(call symfony.console,cache:warmup --no-debug -vvv)

sylius.cache.clean: FORCE=1
sylius.cache.clean: ## Remove application's cache (use FORCE=0 to use the console)
ifeq (${FORCE},0)
	$(call symfony.console,cache:clear --no-warmup)
else
	cd apps/${SYLIUS_FOLDER}; rm -rf var/cache/*
endif

sylius.cache.clean.soft: ## Remove application caches using console
	${MAKE} sylius.cache.clean FORCE=0

sylius.yarn.upgrade:
	$(call docker-compose,run --rm -u www-data -e GULP_MODE=${GULP_MODE} --entrypoint /bin/bash node -c "cd apps/${SYLIUS_FOLDER}; yarn upgrade")
