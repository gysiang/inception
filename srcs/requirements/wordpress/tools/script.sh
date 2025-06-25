#!/bin/bash

echo "🔧 script.sh has started running"
# Load env variables

set -e

echo "⏳ Waiting for mariadb..."
while ! mysqladmin ping -h"mariadb" --silent; do
    sleep 1
done
echo "✅ mariadb is ready."

# Use php with increased memory limit for all wp commands
PHP_WP="php -d memory_limit=256M $(which wp) --allow-root"

echo "Creating database if it does not exist..."
mysql -hmariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MARIADB_NAME;"

echo "Granting privileges to wp user..."
mysql -hmariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
mysql -hmariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';"
mysql -hmariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

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

# Run PHP-FPM
exec php-fpm
