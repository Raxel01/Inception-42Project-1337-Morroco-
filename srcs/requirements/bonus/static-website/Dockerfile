FROM debian:bullseye

RUN  apt update && apt-get install -y nginx openssl

CoPY tools /var/www/html

CMD ["nginx", "-g", "daemon off;"]