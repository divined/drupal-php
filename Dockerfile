FROM wodby/drupal-php:7.1

USER root

ENV PHP_URL="https://secure.php.net/get/php-7.1.13.tar.xz/from/this/mirror" PHP_ASC_URL="https://secure.php.net/get/php-7.1.13.tar.xz.asc/from/this/mirror"

RUN set -ex; \
    \
    apk add --update --no-cache --virtual .build-deps \
        autoconf \
        cmake \
        build-base \
        bzip2-dev \
        freetype-dev \
        geoip-dev \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        jpeg-dev \
        libjpeg-turbo-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libpng-dev \
        libtool \
        libxslt-dev \
        openldap-dev \
        pcre-dev \
        postgresql-dev \
        rabbitmq-c-dev \
        php7-dev \
        yaml-dev; \
    \
    git clone https://github.com/longxinH/xhprof; \
    \
    cd xhprof/extension; \
    \
    phpize; \
    \
    ./configure; \
    \
    sudo make && sudo make install; \
    \
    mkdir -p /usr/src; \
	cd /usr/src; \
	\
	wget -O php.tar.xz "$PHP_URL"; \
	\
    docker-php-source extract; \
    \
    pecl install xml; \
    \
    docker-php-ext-enable \
    xhprof \
    xml; \
    \
    su-exec www-data composer clear-cache; \
    docker-php-source delete; \
    apk del .build-deps; \
    pecl clear-cache; \
    \
    rm -rf \
        /usr/src/php/ext/ast \
        /usr/src/php/ext/uploadprogress \
        /usr/include/php \
        /usr/lib/php/build \
        /tmp/* \
        /root/.composer \
        /var/cache/apk/*; \
    \
    if [[ -z "${PHP_DEV}" ]]; then \
        rm -rf /usr/src/php.tar.xz; \
    fi;

USER www-data
