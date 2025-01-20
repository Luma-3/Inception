#!/bin/sh


# while ! nc -z wordpress 3306; do
# 	echo "Waiting for MySQL to be ready..."
# 	sleep 1
# done

mv /tmp/wp-config.php /var/www/wordpress/wp-config.php

# if [ ! -f /var/www/wordpress/wp-config.php ]; then
# 	mv /tmp/wp-config.php /var/www/wordpress/wp-config.php
# fi

/tmp/wp-cli.phar core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_AMDIN_PASS --admin_email=$WP_ADMIN_MAIL --allow-root

# /tmp/wp-cli.phar user create $WP_USER2 $USER2_MAIL --user_pass=$USER2_PASS --allow-root

exec "$@"

# The entrypoint script is a shell script that is run when the container is started.

