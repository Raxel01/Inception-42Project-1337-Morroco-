FROM debian:bullseye

RUN apt update && apt-get update

RUN apt install -y vim          \
                   redis-server \
                   php-redis

RUN sed -i 's/bind 127.0.0.1 ::1/bind 0.0.0.0/g'  /etc/redis/redis.conf

RUN echo "maxmemory 128mb" >> /etc/redis/redis.conf && echo "maxmemory-policy allkeys-lfu" >> /etc/redis/redis.conf

CMD ["redis-server", "--protected-mode", "no"]