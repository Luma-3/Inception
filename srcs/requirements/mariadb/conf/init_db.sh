#!/bin/sh

# Init Mariadb

# mysql_upgrade --user=mysql --datadir=/var/lib/mysql

# service mysql start
# mysqld &

# while ! mysqladmin ping --silent; do
# 	sleep 1
# done

# mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'mariadb' IDENTIFIED BY '${SQL_PASSWORD}';"

# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# # service mysql stop

# rc-service mariadb restart

# exec mysqld_safe

rc-service mariadb start

mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}'; GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%'; FLUSH PRIVILEGES;"

rc-service mariadb stop

exec "$@"