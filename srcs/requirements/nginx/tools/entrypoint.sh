#!/bin/sh
set -e

: "${DOMAIN_NAME:=cjeannin.42.fr}"

if [ ! -f /etc/nginx/ssl/inception.crt ] || [ ! -f /etc/nginx/ssl/inception.key ]; then
  mkdir -p /etc/nginx/ssl
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=GE/L=Mulhouse/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${DOMAIN_NAME%%.*}"
fi

exec "$@"
