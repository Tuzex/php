FROM php:8.0.11-cli-alpine3.14 as base

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && sync \
    && install-php-extensions \
         gd \
         intl \
         mongodb \
         mysqli \
         pdo_mysql \
         redis

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

FROM base as prod

RUN install-php-extensions opcache
RUN mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini

FROM base as dev

RUN install-php-extensions xdebug
RUN mv "${PHP_INI_DIR}/php.ini-development" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini
COPY /conf.d/99-xdebug.ini ${PHP_INI_DIR}/conf.d/99-xdebug.ini
