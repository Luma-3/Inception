FROM alpine:3.18

RUN apk update && apk add -f wget php81 mariadb-client php81-fpm php81-mysqli php81-phar php81-iconv

RUN adduser -D -G www-data www-data

RUN mkdir -p /var/www/

WORKDIR /var/www/wordpress

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY conf/wp-config.php /tmp/wp-config.php

COPY tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]

CMD ["php-fpm81", "-F"]