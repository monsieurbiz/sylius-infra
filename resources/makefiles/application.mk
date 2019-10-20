### APPLICATION
# ¯¯¯¯¯¯¯¯¯¯¯¯¯

app.start: symfony.domain.attach docker.up symfony.server.start ## Start the application

app.stop: docker.stop symfony.server.stop ## Stop the application

app.cache.clean: sylius.cache.clean ## Clean cache
