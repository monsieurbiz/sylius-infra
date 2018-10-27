### TESTING
# ¯¯¯¯¯¯¯¯¯

TEST_ENV=test

test: test-install test-phpunit ## Run all tests

test-install: ## Install test environment
	${MAKE} SYMFONY_ENV=${TEST_ENV} FORCE=1 install

test-run: test-composer test-phpunit ## Run all tests

test-composer: ## Validate composer.json
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; composer validate --strict")

test-phpunit: ## Run PHPUnit tests
	$(call docker-compose,exec --user www-data php bash -c "cd apps/${SYLIUS_FOLDER}; SYMFONY_ENV=${TEST_ENV} ./bin/phpunit || true")
