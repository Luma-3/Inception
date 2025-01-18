#!/bin/sh


# while ! nc -z wordpress 3306; do
# 	echo "Waiting for MySQL to be ready..."
# 	sleep 1
# done

mv /tmp/wp-config.php /var/www/wordpress/wp-config.php

# if [ ! -f /var/www/html/wp-config.php ]; then
# 	mv /var/www/html/wp-config.php.tmp /var/www/html/wp-config.php
# fi

exec "$@"

# The entrypoint script is a shell script that is run when the container is started.

