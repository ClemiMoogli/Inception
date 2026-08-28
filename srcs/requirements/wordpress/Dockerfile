FROM debian:bookworm
RUN apt-get update && apt-get upgrade
RUN apt-get -y install wget
RUN apt-get install -y php8.2 \
php-fpm \
php-mysql \
mariadb-client
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN chown -R root:root /var/www/wordpress

