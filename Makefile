PROJECT = Inception

VFOLDER = ${HOME}/data
# stand For volume Folders

# full docker-compose path
COMPOSE = /home/abait-ta/Desktop/Inception-42Project-1337-Morroco-/srcs/docker-compose.yml

folders:
	mkdir -p ${VFOLDER}
	mkdir -p ${VFOLDER}/wordpress
	mkdir -p ${VFOLDER}/mariadb
	mkdir -p ${VFOLDER}/portainer

up: folders
	docker compose -f ${COMPOSE} up

stop:
	docker compose -f ${COMPOSE} stop
start:
	docker compose -f ${COMPOSE} start
down:
	docker compose -f ${COMPOSE} down
fclean:
	docker compose -f ${COMPOSE} down --rmi all -v
	docker system prune -af
	sudo rm -rf ${HOME}/data 