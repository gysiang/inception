all : up

up :
	@docker-compose -f ./srcs/docker-compose.yml up -d

down :
	@docker-compose -f ./srcs/docker-compose.yml down

stop :
	@docker-compose -f ./srcs/docker-compose.yml stop

start :
	@docker-compose -f ./srcs/docker-compose.yml start

status :
	@docker ps -a

clean :
	./srcs/cleanup.sh

logs :
	@docker-compose -f ./srcs/docker-compose.yml logs -f

re :
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

debug-env:
	@echo "PWD: $(shell pwd)"
	@echo "Checking if .env file exists: "
	@ls -l ./secrets/.env
