FROM debian:bookworm

RUN apt-get update && apt-get upgrade && apt-get install -y \
	php-fpm \
	php-mysql \
	curl \
	sendmail \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf && \
    mkdir -p /run/php


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy setup script
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Set working directory and entrypoint
WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/script.sh"]
