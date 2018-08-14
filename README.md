# Google Reverse Proxy

[![Docker Build Status](https://img.shields.io/docker/build/onisuly/google-reverse-proxy.svg)](https://github.com/onisuly/docker-google-reverse-proxy) [![Docker Automated build](https://img.shields.io/docker/automated/onisuly/google-reverse-proxy.svg)](https://github.com/onisuly/docker-google-reverse-proxy) [![Docker Stars](https://img.shields.io/docker/stars/onisuly/google-reverse-proxy.svg)](https://github.com/onisuly/docker-google-reverse-proxy) [![Docker Pulls](https://img.shields.io/docker/pulls/onisuly/google-reverse-proxy.svg)](https://github.com/onisuly/docker-google-reverse-proxy)

This Dockerfile build an image for [Nginx](https://nginx.org/) with capabilities of reverse proxy google.

## Quick Start

```shell
docker run -d -p 8080:80 --name google-reverse-proxy --restart=always onisuly/google-reverse-proxy
```

## How to use SSL/HTTPS

Suggest to use [LetsEncrypt companion container for nginx-proxy](https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/) to achieve this goal.

## How to enable password protection

```shell
docker run -d -p 8080:80 --name google-reverse-proxy \
-e SECURE=true \
-e USERNAME=your_name \
-e PASSWORD=your_password \
--restart=always \
onisuly/google-reverse-proxy
```

If you want to add multiple users, your can generate .htpasswd file [here](http://www.htaccesstools.com/htpasswd-generator/) and mount it to your container.

```shell
docker run -d -p 8080:80 --name google-reverse-proxy \
-v /your/path/to/.htpasswd:/usr/local/nginx/conf/.htpasswd \
--restart=always \
onisuly/google-reverse-proxy
```

## Thanks:

This docker image is based on [Nginx Module for Google Mirror](https://github.com/cuber/ngx_http_google_filter_module) and learns a lot from [google-reverse-proxy](https://github.com/jokester/Dockerfiles).