FROM php:8.2.1-cli as base

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && sync \
    && install-php-extensions \
         amqp \
         apcu \
         bcmath \
         intl \
         mongodb \
         pdo_pgsql \
         pdo_mysql \
         pdo_sqlite \
         redis \
         xsl

FROM base as prod

RUN install-php-extensions opcache
RUN mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini
COPY /conf.d/99-opcache.ini ${PHP_INI_DIR}/conf.d/99-opcache.ini

FROM base as dev

RUN mv "${PHP_INI_DIR}/php.ini-development" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini

FROM base as dev-xdebug

RUN install-php-extensions xdebug
RUN mv "${PHP_INI_DIR}/php.ini-development" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini
COPY /conf.d/99-xdebug.ini ${PHP_INI_DIR}/conf.d/99-xdebug.ini

FROM base as dev-blackfire

RUN install-php-extensions blackfire
RUN mv "${PHP_INI_DIR}/php.ini-development" "${PHP_INI_DIR}/php.ini"

COPY /conf.d/90-overrides.ini ${PHP_INI_DIR}/conf.d/90-overrides.ini
COPY /conf.d/99-xdebug.ini ${PHP_INI_DIR}/conf.d/99-blackfire.ini
