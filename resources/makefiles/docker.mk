### DOCKER
# ¯¯¯¯¯¯¯¯

define docker-compose
	cd ${DC_DIR} && docker-compose -p ${DC_PREFIX} $(1)
endef
define docker-sync
	cd ${DC_DIR} && docker-sync $(1)
endef

pull: ## Pull the external images
	$(call docker-compose,pull)

build: PULL_FROM=0
build: ## Build the containers
ifeq ($(PULL_FROM),1)
	$(call docker-compose,build --pull)
else
	$(call docker-compose,build)
endif

up: SYNC=0
up: ## Up the containers
ifeq ($(SYNC),1)
	docker volume create --name=sylius_sync
	$(call docker-compose,-f docker-compose-sync.yml up -d)
	$(call docker-sync,clean)
	$(call docker-sync,start)
else
	$(call docker-compose,up -d)
endif

down: SYNC=0
down: ## Down the containers (keep volumes)
ifeq ($(SYNC),1)
	$(call docker-compose,down)
	$(call docker-sync,stop)
else
	$(call docker-compose,down)
endif

destroy: ## Destroy the containers, volumes, networks…
	$(call docker-compose,down -v --remove-orphan)

start: ## Start the containers
	$(call docker-compose,start)

stop: ## Stop the containers
	$(call docker-compose,stop)

restart: ARG=
restart: ## Restart the containers. Use ARG="container-name" if you want to be specific.
	$(call docker-compose,restart ${ARGS=""})

bash: ## Run bash shell on the "bash" container (user www-data)
	$(call docker-compose,exec --user www-data ${BASH_CONTAINER} bash)

rbash: ## Run bash shell on the "bash" container (user root)
	$(call docker-compose,exec --user root ${BASH_CONTAINER} bash)

node-bash: ## Start node bash
	$(call docker-compose,run -u www-data --entrypoint /bin/bash node)

.PHONY: logs
logs: ## Show containers logs
	$(call docker-compose,logs -f)

dc: ARGS=ps
dc: ## Run docker-compose command. Use ARGS="" to pass parameters to docker-compose.
	$(call docker-compose,${ARGS})
