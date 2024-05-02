FROM debian:bullseye


RUN  apt  update && apt-get install -y php7.4\
                                       php-fpm\
                                       php-mysql\
                                       curl \
                                       sendmail\
                                       vim     \
                                       mariadb-client

RUN  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp \
     && wp cli update --allow-root \
     && mkdir -p /var/www/wordpress \
     && wp core download --allow-root --path='/var/www/wordpress' \
     && wp config create --dbname=${DATA_BASENM} --dbuser=${NEWUSERNAME} \
     --dbpass=${USER_PASSWORD} --dbhost=mariadb --path='/var/www/wordpress' --allow-root \
     
     && wp core install --url=${WP_DOMAINNAME} --title=${WP_SITETITLE} --admin_user=${WP_ADMINENAME} \
     --admin_password=${wp_ADMINEPASSWORD} --admin_email=${wp_ADMINEMAIL} --path='/var/www/wordpress' --allow-root \

     && wp user create $NEW_WP_USERNAME $NEW_WP_USEREMAIL --role=$NEWWP_USERROLE --user_pass=$NEW_WPUSER_PASSWORD --path='/var/www/wordpress' --allow-root


CMD [ "php-fpm", "-F" ]