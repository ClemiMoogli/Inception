#!/bin/sh
set -e

# Wait for MariaDB to be ready
until mysqladmin ping -h mariadb --silent; do
    sleep 1
done

# Loading the secrets.
if [ -f /run/secrets/db_password ]; then
    export SQL_PASSWORD="$(cat /run/secrets/db_password)"
fi

if [ -f /run/secrets/wp_admin_password ]; then
    export WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
fi

if [ -f /run/secrets/wp_second_password ]; then
    export WP_SECOND_PASSWORD="$(cat /run/secrets/wp_second_password)"
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then
        wp config create --allow-root \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

        wp core install --allow-root --path='/var/www/wordpress' \
            --url="$DOMAIN_NAME" --title="Inception" \
            --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" \
            --admin_email="$WP_ADMIN_EMAIL"

        # create a second (non-admin) user
        wp user create "$WP_SECOND_USER" "$WP_SECOND_EMAIL" \
            --user_pass="$WP_SECOND_PASSWORD" --role=author --allow-root --path='/var/www/wordpress'
fi

# Exec passed command (start php-fpm)
exec "$@"
