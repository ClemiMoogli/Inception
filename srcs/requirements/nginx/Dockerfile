FROM debian:bookworm
# installation des dependances
RUN apt update && apt upgrade
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y

# insatllation de TSL
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=GE/L=Mulhouse/O=42/OU=42/CN=cjeannin.42.fr/UID=cjeannin"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
