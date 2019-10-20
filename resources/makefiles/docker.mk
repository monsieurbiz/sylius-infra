### DOCKER
# ¯¯¯¯¯¯¯¯

define docker-compose
	cd ${DC_DIR} && docker-compose -p ${DC_PREFIX} $(1)
endef

docker.pull: ## Pull the external images
	$(call docker-compose,pull)

docker.build: PULL_FROM=0
docker.build: ## Build the containers
ifeq ($(PULL_FROM),1)
	$(call docker-compose,build --pull)
else
	$(call docker-compose,build)
endif

docker.up: ## Up the containers
	$(call docker-compose,up -d)

docker.down: ## Down the containers (keep volumes)
	$(call docker-compose,down)

docker.destroy: ## Destroy the containers, volumes, networks…
	$(call docker-compose,down -v --remove-orphan)

docker.start: ## Start the containers
	$(call docker-compose,start)

docker.stop: ## Stop the containers
	$(call docker-compose,stop)

docker.restart: ARG=
docker.restart: ## Restart the containers. Use ARG="container-name" if you want to be specific.
	$(call docker-compose,restart ${ARGS=""})

docker.bash: ## Run bash shell on the "bash" container (user www-data)
	$(call docker-compose,exec --user www-data ${BASH_CONTAINER} bash)

docker.rbash: ## Run bash shell on the "bash" container (user root)
	$(call docker-compose,exec --user root ${BASH_CONTAINER} bash)

docker.node-bash: ## Start node bash
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node)

.PHONY: logs
docker.logs: ## Show containers logs
	$(call docker-compose,logs -f)

docker.dc: ARGS=ps
docker.dc: ## Run docker-compose command. Use ARGS="" to pass parameters to docker-compose.
	$(call docker-compose,${ARGS})
