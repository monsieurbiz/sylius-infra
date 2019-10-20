### THEMING
# ¯¯¯¯¯¯¯¯¯

theme.install: theme.yarn.install theme.build theme.assets.install ## Install everything we need to run theme commands

theme.build: ## Build the theme using gulp
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node -c "cd apps/${SYLIUS_FOLDER}; yarn run gulp")

theme.yarn.install: ## Install yarn dependencies
	$(call docker-compose,run --rm -u www-data --entrypoint /bin/bash node -c "cd apps/${SYLIUS_FOLDER}; yarn install")

theme.assets.install: sylius.theme.assets.install ## Install theme(s) assets
