FROM php:7.0-fpm

MAINTAINER clement@cyber-duck.co.uk

RUN apt-get update && \
    apt-get install -y --force-yes --no-install-recommends \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng12-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        openssh-server \
        git \
        cron \
        nano

# Install the PHP zip extention
RUN docker-php-ext-install zip

# Install the PHP intl extention
# RUN docker-php-ext-install intl

# Install the PHP mysqli extention
RUN docker-php-ext-install mysqli

# Install the PHP pgsql extention
RUN docker-php-ext-install pgsql

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP pdo_pgsql extention
RUN docker-php-ext-install pdo_pgsql

#####################################
# GD:
#####################################

# Install the PHP gd library
RUN docker-php-ext-install gd && \
    docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

#####################################
# xDebug:
#####################################

# Install the xdebug extension
RUN pecl install xdebug && docker-php-ext-enable xdebug
# Copy xdebug configration for remote debugging
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#####################################
# PHP XCache:
#####################################

# Install the php xcache extension
RUN curl -fsSL 'https://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.gz' -o xcache.tar.gz \
    && mkdir -p /tmp/xcache \
    && tar -xf xcache.tar.gz -C /tmp/xcache --strip-components=1 \
    && rm xcache.tar.gz \
    && docker-php-ext-configure /tmp/xcache --enable-xcache \
    && docker-php-ext-install /tmp/xcache \
    && rm -r /tmp/xcache

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer
# Source the bash
RUN . ~/.bashrc

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

ADD ./silverstripe.ini /usr/local/etc/php/conf.d

#####################################
# Aliases:
#####################################
# docker-compose exec php-fpm ss --> php public/framework/cli-script.php
RUN echo '#!/bin/bash\n/usr/local/bin/php /var/www/public/framework/cli-script.php "$@"' > /usr/bin/ss
RUN chmod +x /usr/bin/ss
# Deployer alias
RUN echo '#!/bin/bash\n/usr/local/bin/php /var/www/vendor/bin/dep "$@"' > /usr/bin/dep
RUN chmod +x /usr/bin/dep

RUN rm -r /var/lib/apt/lists/*

RUN usermod -u 1000 www-data

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm"]
