#!/bin/bash

echo "🔧 script.sh has started running"
set -e

PHP_WP="php -d memory_limit=256M $(which wp) --allow-root"

echo "⏳ Waiting for MariaDB to be ready..."
until mysqladmin ping -hmariadb --silent; do
    echo "❌ MariaDB not ready yet, retrying..."
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "⚙️ Generating wp-config.php..."
	$PHP_WP config create --dbname=$MARIADB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root
else
	echo "wp-config.php already exists, skipping config creation."
fi

if ! $PHP_WP core is-installed; then
	echo "🚀 Installing WordPress..."
	$PHP_WP core install --url=$DOMAIN_NAME --title="MySite" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
else
  echo "WordPress is already installed, skipping installation."
fi

echo "👤 Checking visitor user..."
if ! $PHP_WP user get visitor > /dev/null 2>&1; then
    echo "👤 Creating visitor user..."
    $PHP_WP user create visitor visitor@example.com --user_pass=$WP_VISITORPASS --role=subscriber
else
    echo "✅ Visitor user already exists."
fi

echo "✅ WordPress setup complete!"
exec php-fpm8.2 -F
