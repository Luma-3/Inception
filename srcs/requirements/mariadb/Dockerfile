FROM alpine:3.18

RUN apk update && apk add -f mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/run/mysqld /var/lib/mysqld

RUN chown -R mysql:mysql /var/lib/mysqld /run/mysqld /var/run/mysqld 

COPY conf/my.cnf /etc/my.cnf

COPY tools/init_db.sh /tmp/init_db.sh

RUN chmod +x /tmp/init_db.sh

ENTRYPOINT ["/tmp/init_db.sh"]
