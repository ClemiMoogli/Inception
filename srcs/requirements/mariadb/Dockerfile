FROM alpine:3.23
RUN apk update && apk add mariadb
EXPOSE 3306
COPY entryscript.sh /
RUN chmod +x /entryscript.sh
ENTRYPOINT ["/entryscript.sh"]
