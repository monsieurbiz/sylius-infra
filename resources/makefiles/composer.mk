### COMPOSER
# ¯¯¯¯¯¯¯¯¯¯

composer-create-project: ## Run composer create projet
	$(call docker-compose,exec --user www-data php bash -c "COMPOSER_PROCESS_TIMEOUT=3600 COMPOSER_MEMORY_LIMIT=-1 composer create-project sylius/sylius-standard apps/${SYLIUS_FOLDER}")

composer-install: ## Run composer install
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; COMPOSER_PROCESS_TIMEOUT=3600 COMPOSER_MEMORY_LIMIT=-1 composer install -o --prefer-source")

composer-install-dist: ## Run composer install (prefer dist)
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; COMPOSER_PROCESS_TIMEOUT=3600 composer install -o --prefer-dist")

composer-install-dist-no-interaction: ## Run composer install (prefer dist, no interaction)
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; COMPOSER_PROCESS_TIMEOUT=3600 composer install -o --prefer-dist -n")

composer-install-no-script: ## Run composer install without scripts
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; COMPOSER_PROCESS_TIMEOUT=3600 composer install -o --prefer-source --no-scripts")

composer-dump-autoload: ## Dump Composer autoload (optimized)
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; COMPOSER_PROCESS_TIMEOUT=3600 composer dump -o")
