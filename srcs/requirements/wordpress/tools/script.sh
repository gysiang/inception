#!/bin/bash

echo "🔧 script.sh has started running"

set -e

PHP_WP="php -d memory_limit=256M $(which wp) --allow-root"

echo "⏳ Waiting for MariaDB to be ready..."
until mysqladmin ping -hmariadb --silent; do
    echo "❌ MariaDB not ready yet, retrying..."
    sleep 2
done

# Ensure WordPress core is present
if [ ! -f /var/www/html/wp-load.php ]; then
	echo "📥 Downloading WordPress core..."
	$PHP_WP core download --allow-root
fi

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "⚙️ Generating wp-config.php..."
	$PHP_WP config create --dbname=$MARIADB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root
else
	echo "wp-config.php already exists, skipping config creation."
fi

if ! $PHP_WP core is-installed; then
	echo "🚀 Installing WordPress..."
	$PHP_WP core install --url=$DOMAIN_NAME --title="MySite" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN --admin_email=$WP_ADMIN_EMAIL
else
  echo "WordPress is already installed, skipping installation."
fi

echo "👤 Creating visitor user..."
wp user create visitor visitor@example.com --user_pass=$WP_VISITOR --role=subscriber --allow-root

echo "✅ WordPress setup complete!"

exec php-fpm8.2 -F
