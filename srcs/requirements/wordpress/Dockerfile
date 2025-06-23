FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    mariadb-client \
    less \
    unzip \
    wget \
    curl \
    libzip-dev \
    zip \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy setup script
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Set working directory and entrypoint
WORKDIR /var/www/html
ENTRYPOINT ["/usr/local/bin/script.sh"]
