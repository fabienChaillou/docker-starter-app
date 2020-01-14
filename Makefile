.PHONY: infra-clean infra-shell-php infra-shell-node infra-show-containers infra-stop infra-up

default: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | sort | awk '{split($$0, a, ":"); printf "\033[36m%-30s\033[0m %-30s %s\n", a[1], a[2], a[3]}'
#
# Executes a command in a running container, mainly useful to fix the terminal size on opening a shell session
#
# $(1) the options
#
define infra-shell
	docker-compose exec -e COLUMNS=`tput cols` -e LINES=`tput lines` $(1)
endef


########################################
#                APP                   #
########################################


########################################
#              INFRA                   #
########################################

infra-clean: ## to stop and remove containers, networks, images
	@docker-compose down --rmi all

infra-shell-php: ## to open a shell session in the php-fpm container
	@$(call infra-shell, -u www-data php_fpm sh)

infra-shell-node: ## to open a shell session in the node container
	@$(call infra-shell,node sh)

infra-show-containers: ## to show all the containers running
	@docker ps

infra-stop: ## to stop all the containers
	@docker-compose stop

infra-up: ## to start all the containers
	@docker-compose up --build -d

