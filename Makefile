PROJECT = Inception

VFOLDER = ${HOME}/data

COMPOSE = $$PWD/srcs/docker-compose.yml

folders:
	mkdir -p ${VFOLDER}
	mkdir -p ${VFOLDER}/wordpress
	mkdir -p ${VFOLDER}/mariadb
	mkdir -p ${VFOLDER}/portainer

up: folders
	docker compose -f ${COMPOSE} up -d

stop:
	docker compose -f ${COMPOSE} stop
start:
	docker compose -f ${COMPOSE} start
restart:
	docker compose -f ${COMPOSE} restart 
down:
	docker compose -f ${COMPOSE} down -v
	sudo rm -rf ${HOME}/data

fclean:
	docker compose -f ${COMPOSE} down --rmi all -v
	docker system prune -af
	sudo rm -rf ${HOME}/data 