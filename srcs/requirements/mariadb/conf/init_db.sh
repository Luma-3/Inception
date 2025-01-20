#!/bin/sh

# Init Mariadb

mysqld &

DB_ALREADY_EXISTS=`mysql -u root -e "SHOW DATABASES" | grep ${SQL_DATABASE}`

if [ -n "$DB_ALREADY_EXISTS" ]; then
	echo "Database already exists"
else
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
fi

# service mysql start

while ! mysqladmin ping --silent; do
	sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'mariadb' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

exec mysqld_safe
