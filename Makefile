include docker/.env

.DEFAULT_GOAL = help

.PHONY: help docker-start docker-stop test test-php74 test-php80

DOCKER_COMPOSE_COMMAND=docker-compose -f ./docker/docker-compose.yml
DOCKER_PHP74=phpfolio-php74
DOCKER_PHP80=phpfolio-php80

help: ## How to use it
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

docker-start: ## (Re)run, and build if needed, the development containers
	$(MAKE) docker-stop
	$(DOCKER_COMPOSE_COMMAND) up -d --build --remove-orphans --force-recreate

docker-stop: ## Stop all containers and remove them
	cd docker && docker-compose down

test: ## Run the docker containers, start the tests, stop the containers
	$(MAKE) docker-start
	$(MAKE) test-php74
	$(MAKE) test-php80
	$(MAKE) docker-stop

test-php74: ## Run tests for php7.4
	@echo ">> Start to run PHP7.4 tests"
	docker exec -it $(DOCKER_PHP74) composer install
	docker exec -it $(DOCKER_PHP74) php vendor/bin/phpunit -c phpunit.xml
	docker exec -it $(DOCKER_PHP74) php vendor/bin/phpstan analyse src tests
	docker exec -it $(DOCKER_PHP74) php vendor/bin/phpcs --standard=PSR12 src

test-php80: ## PHPUnit test for php8.0
	@echo ">> Start to run PHP8.0 tests"
	docker exec -it $(DOCKER_PHP80) composer install
	docker exec -it $(DOCKER_PHP80) php vendor/bin/phpunit -c phpunit.xml
	docker exec -it $(DOCKER_PHP80) php vendor/bin/phpstan analyse src tests
	docker exec -it $(DOCKER_PHP80) php vendor/bin/phpcs --standard=PSR12 src
