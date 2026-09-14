FROM debian:bookworm
RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y
RUN rm -rf /var/lib/666666666666666666666666666666/*
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/entryscript.sh /
RUN chmod +x /entryscript.sh
ENTRYPOINT ["/entryscript.sh"]
