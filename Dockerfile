FROM alpine:latest
MAINTAINER onisuly <onisuly@gmail.com>

ARG BUILD_DEP="build-base wget tar openssl-dev pcre-dev zlib-dev"
ARG RUN_DEP="openssl pcre zlib apache2-utils"
ARG PKGNAME_NGINX=nginx-1.12.2
ARG PKGNAME_MOD1=ngx_http_google_filter_module-0.2.0
ARG PKGNAME_MOD2=ngx_http_substitutions_filter_module-0.6.4

RUN apk add --no-cache $RUN_DEP \ 
    && apk add --no-cache --virtual build-dependencies $BUILD_DEP \
    && mkdir -p /var/tmp \
    && cd /var/tmp \
    && wget https://nginx.org/download/$PKGNAME_NGINX.tar.gz -O $PKGNAME_NGINX.tar.gz \
    && tar zxf $PKGNAME_NGINX.tar.gz \
    && wget https://github.com/cuber/ngx_http_google_filter_module/archive/0.2.0.tar.gz -O $PKGNAME_MOD1.tar.gz \
    && tar zxf $PKGNAME_MOD1.tar.gz \
    && wget https://github.com/yaoweibin/ngx_http_substitutions_filter_module/archive/v0.6.4.tar.gz -O $PKGNAME_MOD2.tar.gz \
    && tar zxf $PKGNAME_MOD2.tar.gz \
    && cd $PKGNAME_NGINX \
    && ./configure \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-ipv6 \
    --add-module=../$PKGNAME_MOD1 \
    --add-module=../$PKGNAME_MOD2 \
    && make install \
    && rm -rf /var/tmp/* \
    && apk del build-dependencies

COPY nginx_basic.conf /usr/local/nginx/conf/nginx_basic.conf
COPY nginx_auth.conf /usr/local/nginx/conf/nginx_auth.conf
COPY startup.sh /script/startup.sh
RUN chmod +x /script/startup.sh

EXPOSE 80

CMD ["/script/startup.sh"]
