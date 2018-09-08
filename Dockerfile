FROM wodby/drupal-php:7.1

USER root

ENV PHP_URL="https://secure.php.net/get/php-7.1.13.tar.xz/from/this/mirror"

RUN set -ex; \
    \
    mkdir -p /usr/src; \
    cd /usr/src; \
    \
    wget -O php.tar.xz "$PHP_URL"; \
    \
    apk add --update --no-cache gmp gmp-dev && docker-php-ext-install gmp
