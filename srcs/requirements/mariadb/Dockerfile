FROM alpine:3.18

RUN apk update && apk add -f mariadb mariadb-client

RUN mkdir -p /run/mysqld

RUN chown -R mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/init_db.sh /tmp/init_db.sh

CMD ["sh", "/tmp/init_db.sh"]