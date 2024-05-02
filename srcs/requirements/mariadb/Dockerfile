FROM debian:bullseye

RUN  apt update && apt install mariadb-server -y 

COPY ./tools/startAndConf.sh /tmp/startAndConf.sh

RUN chmod 777 /tmp/startAndConf.sh &&  cd /tmp && bash startAndConf.sh

ENTRYPOINT ["mysqld"]