FROM debian:bullseye

ARG DATA_BASENM
ARG NEWUSERNAME
ARG USER_PASSWORD
ARG NEWROOT_PASSWORD

RUN  apt update && apt install mariadb-server -y 

COPY ./tools/startAndConf.sh /tmp/startAndConf.sh

RUN chmod 777 /tmp/startAndConf.sh &&  cd /tmp && bash startAndConf.sh

ENTRYPOINT ["mysqld"]