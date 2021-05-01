FROM php:8.0-fpm

RUN apt-get -y update \
    && apt-get -y autoremove \
    && apt-get clean \
    && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    zip \
    unzip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
