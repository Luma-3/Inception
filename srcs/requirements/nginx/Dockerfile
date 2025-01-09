FROM alpine:3.18

RUN apk update && apk add -f nginx openssl coreutils

# Nginx user

RUN adduser -D -G www-data www-data

# SSL certificate

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj '/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jbrousse.42.fr/UID=jbrousse'

# Nginx configuration

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Premission website

# TODO enlever plus tard avec les volumes
RUN mkdir -p /var/www/wordpress 

RUN chmod 755 /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

CMD ["nginx", "-g", "daemon off;"]