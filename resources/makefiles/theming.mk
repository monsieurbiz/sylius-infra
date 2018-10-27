### THEMING
# ¯¯¯¯¯¯¯¯¯

theme-install: yarn-install theme-build ## Install everything we need to run theme commands

theme-build: ## Build the theme using gulp
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node -c "cd apps/${SYLIUS_FOLDER}; yarn run gulp")

yarn-install: ## Install yarn dependencies
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node -c "cd apps/${SYLIUS_FOLDER}; yarn install")

theme-assets-install: ## Install theme(s) assets
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; bin/console sylius:theme:assets:install --symlink --relative -e ${SYMFONY_ENV} public")
