#!/bin/sh
set -e

SECURE=${SECURE:=false}

if [ $SECURE = 'true' ]; then
    if [ -f /usr/local/nginx/.htpasswd ]; then
        rm -f /usr/local/nginx/.htpasswd
    fi
    htpasswd -b -c /usr/local/nginx/.htpasswd ${USERNAME} ${PASSWORD}
    cp /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.bak
fi

if [ -f /usr/local/nginx/.htpasswd ]; then
    if [ -f /usr/local/nginx/conf/nginx.conf.bak ]; then
        cp /usr/local/nginx/conf/nginx.conf.bak /usr/local/nginx/conf/nginx.conf
    fi
    sed -i '/google_scholar on;/ a\            auth_basic "Restricted Content";\n            auth_basic_user_file /usr/local/nginx/.htpasswd;' /usr/local/nginx/conf/nginx.conf
fi

/usr/local/nginx/sbin/nginx
