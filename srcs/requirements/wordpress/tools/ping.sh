#!/bin/bash

DATA_BASENM="MYDB"
NEWUSERNAME="CANIS"
USER_PASSWORD="CANIS2001"
NEWROOT_PASSWORD="ROOT@NoLiFE"
WP_DOMAINNAME="abait-ta.42.fr"
WP_SITETITLE="MyWebsite"
WP_ADMINENAME="sinac"
wp_ADMINEPASSWORD="canis**0002"
wp_ADMINEMAIL="aittalbabdelalie@gmail.com"
NEW_WP_USERNAME="canis"
NEW_WP_USEREMAIL="nofat@gmail.com"
NEW_WPUSER_PASSWORD="WENPASS2001"
NEWWP_USERROLE="Editor"
DBHOST="mariadb"
# TOREMOVE AFTE

IFS=$'\n'

for line in $(cat /etc/php/7.4/fpm/pool.d/www.conf); do
  modified_line="${line/listen = \/run\/php\/php7.4-fpm.sock/listen = wordpress:9000}"
  echo "$modified_line" >> temp.txt
done
mv temp.txt /etc/php/7.4/fpm/pool.d/www.conf

until mysqladmin ping -h"$DBHOST" -P"3306" -u"$NEWUSERNAME" -p"$USER_PASSWORD" ; do
     echo 'waiting for mariadb to be connectable...'
     sleep 2
done

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    mkdir -p /var/www/wordpress
    cd /var/www/wordpress/
    
    wp core download --allow-root
    
    touch wp-config.php

    chmod 777  wp-config.php
    
    cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

    IFS=$'\n'

    for line in $(cat /var/www/wordpress/wp-config.php); do
      echo "|------| $modified_line |------|"
      modified_line="${line/\'database_name_here\'/\'${DATA_BASENM}\'}"
      modified_line="${line/\'username_here\'/\'${NEWUSERNAME}\'}"
      modified_line="${line/\'password_here\'/\'${USER_PASSWORD}\'}"
      modified_line="${line/\'DB_HOST\'/\'${DBHOST}\'}"
      echo "$modified_line" >> tempo.txt
    done
    cp tempo.txt /var/www/wordpress/wp-config.php

    # wp config create --dbname=${DATA_BASENM} --dbuser=${NEWUSERNAME} --dbpass=${USER_PASSWORD} --dbhost=${DBHOST} --path='/var/www/wordpress' --allow-root

    wp core install --url=$WP_DOMAINNAME --title=$WP_SITETITLE --admin_user=$WP_ADMINENAME --admin_password=$wp_ADMINEPASSWORD --admin_email=$wp_ADMINEMAIL --path='/var/www/wordpress' --allow-root

    wp user create $NEW_WP_USERNAME $NEW_WP_USEREMAIL --role=$NEWWP_USERROLE --user_pass=$NEW_WPUSER_PASSWORD --path='/var/www/wordpress' --allow-root
else
    echo "Wordpress is already installed"
fi

exec "$@"