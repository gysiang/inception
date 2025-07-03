FROM debian:bullseye

# Set noninteractive mode for APT
ENV DEBIAN_FRONTEND=noninteractive

# Add SURY PHP repository
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    lsb-release \
    apt-transport-https \
    gnupg2 && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/php.gpg && \
    apt-get update

# Install PHP 8.2 + FPM
RUN apt-get install -y php8.2 php8.2-fpm php8.2-mysql && \
    php -v && \
    php-fpm8.2 -v && \
    which php-fpm8.2 && \
    ls -l /usr/sbin/php-fpm*
    
RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

RUN mkdir -p /run/php 
RUN chown -R www-data:www-data /run/php

CMD ["php-fpm8.2", "-F"]
