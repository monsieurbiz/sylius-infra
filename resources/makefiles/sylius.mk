### SYLIUS
# ¯¯¯¯¯¯¯¯

console: ARGS=
console: ## Run console command, as example: make console ARGS="doctrine:schema:update --force -e dev"
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console ${ARGS}")

sylius-install: sylius-refresh-db sylius-assets-install ## Install Sylius

sylius-refresh-db: sylius-reset-db-schema sylius-fixtures-load ## Refresh Sylius database with fixtures (⚠ Reset database)

sylius-reset-db-schema: sylius-doctrine-metadata-clear ## Reset database schema (⚠ Reset database)
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console doctrine:database:drop -e ${SYMFONY_ENV} --force || true")
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console sylius:install:database -e ${SYMFONY_ENV} -n")

sylius-doctrine-metadata-clear: ## Clear Doctrine's metadata
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console doctrine:cache:clear-metadata -e ${SYMFONY_ENV}")

sylius-fixtures-load: SUITE=default
sylius-fixtures-load: ## Load Fixtures (use SUITE="" if you want to change the suite)
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console sylius:fixtures:load -e ${SYMFONY_ENV} -n ${SUITE}")

sylius-assets-install: ## Install sylius assets
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console assets:install --symlink --relative -e ${SYMFONY_ENV} public")

sylius-warmup: ## Warmup the cache
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console cache:warmup --env=${SYMFONY_ENV} --no-debug -vvv")

clean-cache: FORCE=1
clean-cache: ## Remove application cache using rm
ifeq (${FORCE},0)
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console cache:clear -e ${SYMFONY_ENV}")
else
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; rm -rf var/cache/*")
endif

clean-cache-soft: ## Remove application caches using console
	${MAKE} clean-cache FORCE=0
