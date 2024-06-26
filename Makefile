ifeq (,$(wildcard .env))
    $(shell cp .env.example .env)
endif

include .env
export $(shell sed 's/=.*//' .env)

devup:
	USER=$$(id -u):$$(id -g) docker compose up -d --remove-orphans

devinstall:
	@docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-php-1 composer install
	@docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-web-1 yarn
	@docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-node-1 yarn
	@test -f api/.env || (cp api/.env.example api/.env && docker exec -it $(COMPOSE_PROJECT_NAME)-php-1 php artisan key:generate)
	@docker exec -it $(COMPOSE_PROJECT_NAME)-php-1 sh -c "chown -R :www-data storage/* bootstrap/cache"
	@test -d .vscode || (mkdir .vscode && echo '{ "eslint.workingDirectories": [ "web" ] }' > .vscode/settings.json)

devshphp:
	docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-php-1 sh

devshweb:
	docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-web-1 sh

devrun:
	docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-web-1 yarn dev

devmigrate:
	USER=$$(id -u):$$(id -g) docker exec -it -u $$(id -u):$$(id -g) $(COMPOSE_PROJECT_NAME)-php-1 php artisan migrate

devdown:
	docker compose down --remove-orphans

devclean: devdown
	sudo rm -rf .data
