#!/bin/sh

# arreter le sricpt directement en cas d'erreur
set -e

if [! -d "/var/lib/mysql/mysql"]; then
    echo "Init de la bdd..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi
