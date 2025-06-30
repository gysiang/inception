#!/bin/bash

set -e
env | grep -E 'MARIADB|WP_' | sort

echo "🚀 Starting MariaDB in background..."
mysqld_safe --datadir=/var/lib/mysql &
sleep 5

until mysqladmin ping --silent; do
    echo "⏳ Waiting for MariaDB to be ready..."
    sleep 2
done

echo "📦 Creating database and user..."
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_NAME};"
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'wordpress.srcs_inception' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MARIADB_NAME}.* TO '${MARIADB_USER}'@'wordpress.srcs_inception';"

mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "mariadb is ready"

wait
