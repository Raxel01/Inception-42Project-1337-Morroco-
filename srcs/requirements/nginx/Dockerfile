FROM debian:bullseye

RUN  apt update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN  openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=/ST=/L=/O=/OU=/CN=/UID="

COPY ./conf/default /etc/nginx/sites-enabled/default

CMD ["nginx", "-g", "daemon off;"]