FROM php:7.3-apache

RUN a2enmod rewrite
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    git \
    libgmp3-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    imagemagick \
    curl \
    libc-dev \
    libpng-dev \
    libzip-dev \
    zip
RUN pecl install xdebug-beta
RUN docker-php-ext-configure gd \
      --with-gd \
      --with-jpeg-dir \
      --with-png-dir \
      --with-zlib-dir
RUN docker-php-ext-install zip pdo pdo_mysql bcmath gd exif

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
