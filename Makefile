all : up

up :
	./srcs/setup.sh
	docker compose -f ./srcs/docker-compose.yml up -d

down :
	docker compose -f ./srcs/docker-compose.yml down

stop :
	docker compose -f ./srcs/docker-compose.yml stop

start :
	docker compose -f ./srcs/docker-compose.yml start

status :
	docker ps -a

clean :
	./srcs/cleanup.sh

logs :
	docker compose -f ./srcs/docker-compose.yml logs -f

rebuild :
	docker compose -f ./srcs/docker-compose.yml up -d --build
