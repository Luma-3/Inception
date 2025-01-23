#!/bin/sh

# Init Mariadb

set -e

DATA_DIR=/var/lib/mysql

signal_terminate_trap() {
	# docker send SIGTERM to main process for leave properly
	mariadb-admin shutdown &
	wait $!
}

trap "signal_terminate_trap" SIGTERM


initialize() {
	if [ ! -f  "$DATA_DIR/ibdata1" ]; then
		 # TODO replace param by variable 
		mariadb-install-db	\
			--user=mysql	\
			--datadir=$DATA_DIR

		wait $!
		echo "MariaDB Initialization OK !"
	else
		echo "MariaDB is already Initialized"
	fi
}


create_db() {
	mariadb -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

	mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'mariadb' IDENTIFIED BY '${SQL_PASSWORD}';"

	mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

	mariadb -e "FLUSH PRIVILEGES;"

	mariadb-admin -u root -p$SQL_ROOT_PASSWORD shutdown

	exec mariadbd-safe
}

run() {
	echo "Starting MariaDB..."

	mariadbd &

	while ! mariadb-admin ping --silent ; do
		echo "MariaDB is not ready yet, retrying..."
		sleep 1
	done

	echo "coucou"

	create_db
	exit 1
}

initialize

run




# mysqld &

# # DB_ALREADY_EXISTS=`mysql -u root -e "SHOW DATABASES" | grep ${SQL_DATABASE}`

# # if [ -n "$DB_ALREADY_EXISTS" ]; then
# # 	echo "Database already exists"
# # else
# # 	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
# # fi

# cd '/usr'; /usr/bin/mariadb-safe --datadir='/var/lib/mysql'

# # service mysql start

# while ! mysqladmin ping --silent; do
# 	sleep 1
# done

# mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'mariadb' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# exec mysqld_safe