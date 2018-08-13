#!/bin/sh
set -e

SECURE=${SECURE:=false}

if [ $SECURE = 'true' ]; then
    if [ -f /usr/local/nginx/.htpasswd ]; then
        rm -f /usr/local/nginx/.htpasswd
    fi
    htpasswd -b -c /usr/local/nginx/.htpasswd ${USERNAME} ${PASSWORD}
fi

if [ -f /usr/local/nginx/.htpasswd ]; then
    sed -i '/google_scholar on;/ a\            auth_basic "Restricted Content";\n            auth_basic_user_file /usr/local/nginx/.htpasswd;' usr/local/nginx/conf/nginx.conf
fi

/usr/local/nginx/sbin/nginx
