FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y wget php8.2 php8.2-fpm php-mysql mariadb-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
 && cd /var/www && tar -xvf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress

# installer le CLI WP pour configurer wp-config.php
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp

COPY conf/auto_config.sh /
RUN chmod +x /auto_config.sh

ENTRYPOINT ["/auto_config.sh"]

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]
