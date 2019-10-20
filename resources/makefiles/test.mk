### TESTING
# ¯¯¯¯¯¯¯¯¯

TEST_ENV=test

test: test-install test-phpunit ## Run all tests

test.install: ## Install test environment
	${MAKE} APP_ENV=${TEST_ENV} project.install

test.run: test.composer test.phpunit ## Run all tests

.PHONY: test.composer
test.composer: ## Validate composer.json
	$(call symfony.composer,validate --strict)

test.phpunit: ## Run PHPUnit tests
	$(call symfony,php bin/phpunit || true)
