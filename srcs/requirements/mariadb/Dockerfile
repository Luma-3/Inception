FROM alpine:3.18

RUN apk update && apk add -f mariadb mariadb-client openrc

RUN mkdir -p /run/mysqld /var/run/mysqld /var/lib/mysqld

RUN chown -R mysql:mysql /var/lib/mysqld /run/mysqld /var/run/mysqld 

# RUN chgrp -R mysql /var/lib/mysql

COPY conf/my.cnf /etc/my.cnf

COPY conf/init_db.sh /tmp/init_db.sh

RUN chmod +x /tmp/init_db.sh

ENTRYPOINT ["/tmp/init_db.sh"]
