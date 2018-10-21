### THEMING
# ¯¯¯¯¯¯¯¯¯

theme-install: yarn-install theme-build ## Install everything we need to run theme commands

theme-build: ## Build the theme using gulp
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node -c "cd apps/sylius; yarn run gulp")

yarn-install: ## Install yarn dependencies
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node -c "cd apps/sylius; yarn install")

theme-assets-install: ## Install theme(s) assets
	$(call docker-compose,exec --user www-data php bash -c "cd apps/sylius; console sylius:theme:assets:install --symlink --relative -e ${SYMFONY_ENV} public")
