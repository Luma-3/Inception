FROM alpine:3.18

RUN apk update && apk add -f mariadb mariadb-client openrc

RUN mkdir -p /run/mysqld

RUN chown -R mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/my.cnf.d/50-server.cnf

COPY conf/init_db.sh /tmp/init_db.sh

RUN chmod +x /tmp/init_db.sh

ENTRYPOINT ["/tmp/init_db.sh"]

CMD ["mysqld", "--user=mysql", "--console"]