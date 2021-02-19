.SILENT:

.PHONY: help
help: ## Show this help message
	@printf '\033[32mUsage: make [target] ...\033[0m\n\nAvailable targets:\n\n'
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

up: ## Start stack
	docker-compose up -d

down: ## Stop stack
	docker-compose down

restart: ## Restart stack
restart: down up

status: ## Show stack status
	docker-compose ps

pull: ## Pull required images
	docker-compose pull
