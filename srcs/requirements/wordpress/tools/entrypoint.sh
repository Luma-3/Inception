#!/bin/sh

set -e

while ! mariadb-admin ping --silent --host=mariadb --port=3306 ; do
	echo "MariaDB is not ready yet, retrying..."
	sleep 1
done

# mv /tmp/wp-config.php /var/www/wordpress/wp-config.php

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	# Init wordpress if not already done

	echo "Init Wordpress..."
	mv /tmp/wp-config.php /var/www/wordpress/wp-config.php
	wget https://wordpress.org/latest.tar.gz -O /latest.tar.gz
	cd /var/www/
	tar -xvf /latest.tar.gz
	rm -f /latest.tar.gz
	chown -R www-data:www-data /var/www/wordpress
	cd /var/www/wordpress



	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /tmp/wp-cli.phar && chmod +x /tmp/wp-cli.phar

	/tmp/wp-cli.phar core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL --allow-root
	/tmp/wp-cli.phar user create $WP_USER2 $WP_USER2_MAIL --user_pass=$WP_USER2_PASS --allow-root

	rm -f /tmp/wp-cli.phar
fi




exec "$@"

# The entrypoint script is a shell script that is run when the container is started.

