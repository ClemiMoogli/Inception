#!/bin/sh


sleep 10
if [ ! -f wp-config.php ]; then
    wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --path='/var/www/wordpress'
fi
# wp core install pour configurer la deuxieme page
# wp user create pour configurer le deuxieme utilisateur
