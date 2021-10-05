FROM php:7.3.30-fpm-alpine3.13 as base

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

FROM base as prod

RUN install-php-extensions opcache
RUN mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini

FROM base as dev

RUN install-php-extensions xdebug
RUN mv "${PHP_INI_DIR}/php.ini-development" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini
COPY /conf.d/99-xdebug.ini ${PHP_INI_DIR}/conf.d/99-xdebug.ini
