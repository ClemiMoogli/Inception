FROM alpine:3.23
RUN apk update && apk add mariadb
EXPOSE 3306
CMD ["mysqld", "--user=mysql"]
