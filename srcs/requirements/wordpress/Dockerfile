FROM debian:bookworm

RUN apt-get update && apt-get install -y \
        php8.2 \
        php8.2-fpm \
        php8.2-mysql \
        curl \
        vim \
        mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/ping.sh ping.sh


RUN  mkdir -p /run/php && chmod +x ping.sh

ENTRYPOINT ["./ping.sh"]

CMD ["/usr/sbin/php-fpm8.2", "-F"]
