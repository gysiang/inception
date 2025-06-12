#!/bin/bash

# Load env variables
source /var/www/html/.env

# Set working dir
cd /var/www/html

# Wait for MySQL to be ready
echo "⏳ Waiting for MySQL..."
while ! mysqladmin ping -h"mariadb" --silent; do
    sleep 1
done
echo "✅ MySQL is ready."

# Download WordPress core files if not present
if [ ! -f wp-config.php ]; then
    echo "📥 Downloading WordPress..."
    wp core download --allow-root
fi

# Create wp-config.php if not present
if [ ! -f wp-config.php ]; then
    echo "⚙️ Generating wp-config.php..."
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
fi

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "🚀 Installing WordPress..."
    echo "👤 Creating admin user..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Inception - 42" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
    echo "👤 Creating visitor user..."
    wp user create "$DB_VISITOR" "visitor@example.com" \
        --role=subscriber \
        --user_pass="$DB_VISITORPASS" \
        --allow-root
else
    echo "✅ WordPress is already installed."
fi

exec "$@"
