#!/bin/bash


IFS=$'\n'

for line in $(cat /etc/php/7.4/fpm/pool.d/www.conf); do
  modified_line="${line/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000}"
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
    wp core download  --allow-root
    touch wp-config.php
    echo "waaaaaawWWSWWAAWAWAW====================="
    chmod 777  wp-config.php
    cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
    sed -i "s/database_name_here/$DATA_BASENM/g" /var/www/wordpress/wp-config.php
    sed -i "s/username_here/$NEWUSERNAME/g" /var/www/wordpress/wp-config.php
    sed -i "s/password_here/${USER_PASSWORD}/g" /var/www/wordpress/wp-config.php
    sed -i "s/localhost/mariadb/g" /var/www/wordpress/wp-config.php

    wp core install --url=$WP_DOMAINNAME --title=$WP_SITETITLE --admin_user=$WP_ADMINENAME --admin_password=$wp_ADMINEPASSWORD --admin_email=$wp_ADMINEMAIL --path='/var/www/wordpress' --allow-root
    wp user create $NEW_WP_USERNAME $NEW_WP_USEREMAIL --role=$NEWWP_USERROLE --user_pass=$NEW_WPUSER_PASSWORD --path='/var/www/wordpress' --allow-root
else
    echo "Wordpress is already installed"
fi

exec "$@"