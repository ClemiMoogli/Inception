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

# installer le CLI WP pour configurer wp-config.php
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/auto_config.sh /
RUN chmod +x /auto_config.sh
ENTRYPOINT ["/auto_config.sh"]

# Faire une commande qui cree /run/php si il n'existe pas
# lancer php-fpm avec "/usr/sbin/php-fpm7.3 -F"
