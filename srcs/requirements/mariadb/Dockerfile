FROM debian:bookworm

RUN apt update; \
	apt install -y mariadb-server mariadb-client bash tzdata

RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/script.sh"]
