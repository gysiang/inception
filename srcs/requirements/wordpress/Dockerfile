FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    lsb-release \
    apt-transport-https \
    gnupg2 && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/php.gpg && \
    apt-get update

RUN apt-get install -y php8.2 php8.2-fpm php8.2-mysql && \
    php -v && \
    php-fpm8.2 -v && \
    which php-fpm8.2 && \
    ls -l /usr/sbin/php-fpm*

RUN apt-get update && apt-get install -y \
    unzip \
    sendmail \
    mariadb-client \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Fix FPM listen socket
RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf && \
    mkdir -p /run/php

# Install WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Set working directory and entrypoint
WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/script.sh"]
