FROM debian:bullseye

RUN  apt  update && apt-get install -y php7.4\
                                       php-fpm\
                                       php-mysql\
                                       curl \
                                       sendmail\
                                       vim \
                                       mariadb-client
COPY ./tools/ping.sh ping.sh


RUN  mkdir -p /run/php && chmod +x ping.sh

ENTRYPOINT ["./ping.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]