FROM alpine:3.18

RUN apk update && apk add -f wget php81 mariadb-client php81-fpm php81-mysqli

RUN wget https://wordpress.org/latest.tar.gz

RUN adduser -D -G www-data www-data

RUN mkdir -p /var/www/

RUN cd /var/www/ && tar -xvf /latest.tar.gz && rm -f /latest.tar.gz

RUN chown -R root:root /var/www/wordpress

WORKDIR /var/www/wordpress

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY conf/wp-config.php /tmp/wp-config.php

COPY conf/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["php-fpm81", "-F"]