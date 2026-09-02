FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# installation des dependances
RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y nginx vim curl openssl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Prepare directories
RUN mkdir -p /etc/nginx/ssl /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chmod 755 /var/www
RUN chown -R www-data:www-data /var/www

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
