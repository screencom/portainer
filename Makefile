.SILENT:

.PHONY: help
help: ## Show this help message
	@printf '\033[32mUsage: make [target] ...\033[0m\n\nAvailable targets:\n\n'
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

SWARM := $(shell docker info --format '{{.Swarm.LocalNodeState}}')

up: ## Start stack
ifeq ($(SWARM), active)
	docker stack deploy -c docker-stack.yml portainer
else
	docker-compose up -d
endif

down: ## Stop stack
ifeq ($(SWARM), active)
	docker stack rm portainer
else
	docker-compose down
endif

restart: ## Restart stack
restart: down up

status: ## Show stack status
ifeq ($(SWARM), active)
	docker stack ps portainer
else
	docker-compose ps
endif

pull: ## Pull required images
ifeq ($(SWARM), active)
	echo "there is no need to pull in swarm mode"
else
	docker-compose pull
endif

gitpull: ## Update git repo
	git pull

update: ## Update this repo and restart
update: down pull gitpull up
