FROM php:8.1-fpm

# install dep
RUN apt update && apt-get install -y  \
    wget \
    unzip \
    mariadb-client\
    && docker-php-ext-install mysqli pdo pdo_mysql

# Download and extract wordpress
RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mv wordpress/* . && \
    rm -rf wordpress latest.zip

# set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm"]