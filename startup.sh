#!/bin/sh
set -e

SECURE=${SECURE:=false}

if [ $SECURE = 'true' ]; then
    if [ -f /usr/local/nginx/.htpasswd ]; then
        rm -f /usr/local/nginx/.htpasswd
    fi
    htpasswd -b -c /usr/local/nginx/.htpasswd ${USERNAME} ${PASSWORD}
    cp -f /usr/local/nginx/conf/nginx_auth.conf /usr/local/nginx/conf/nginx.conf
fi

/usr/local/nginx/sbin/nginx
