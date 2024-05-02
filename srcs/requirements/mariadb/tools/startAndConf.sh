#!/bin/bash

#Megrate them To .envfile!
DATA_BASENM="MYDB"
NEWUSERNAME="CANIS"
USER_PASSWORD="CANIS2001"
NEWROOT_PASSWORD="ROOT@NoLiFE"
#---------------------------------------#
IFS=$'\n'

for line in $(cat /etc/mysql/mariadb.conf.d/50-server.cnf); do
  modified_line="${line/127.0.0.1/0.0.0.0}"
  echo "$modified_line" >> temp.txt
done

mv temp.txt /etc/mysql/mariadb.conf.d/50-server.cnf

#Empty tempFile
echo -n > temp.txt

for line in $(cat /etc/mysql/mariadb.cnf); do
  modified_line="${line/\# port = 3306/ port = 3306}"
  echo "$modified_line" >> temp.txt
done

mv temp.txt /etc/mysql/mariadb.cnf

service mariadb start
sleep 5

mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS ${DATA_BASENM} ; \
CREATE USER IF NOT EXISTS '$NEWUSERNAME'@'%' IDENTIFIED BY '$USER_PASSWORD'; \
GRANT ALL PRIVILEGES ON $DATA_BASENM.* TO '$NEWUSERNAME'@'%'; \
ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEWROOT_PASSWORD'; \
FLUSH PRIVILEGES;"

# should Change the 3306
