#!/bin/sh
set -e

if [ -f /run/secrets/db_password ]; then
  export SQL_PASSWORD="$(cat /run/secrets/db_password)"
fi
if [ -f /run/secrets/db_root_password ]; then
  export SQL_ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Init de la bdd..."
  service mysql start

  while ! mysqladmin ping 2>/dev/null; do
    sleep 1
  done

  mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
  mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
  mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
  mysql -e "FLUSH PRIVILEGES;"
  mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
fi

exec mysqld_safe
