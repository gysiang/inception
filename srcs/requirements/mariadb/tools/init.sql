-- Select the database to use (created via MYSQL_DATABASE)
CREATE DATABASE IF NOT EXISTS wp_database;

-- Admin user (must NOT contain "admin" in any form)
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

-- Normal user
CREATE USER IF NOT EXISTS 'wp_visitor'@'%' IDENTIFIED BY 'wp_pass1';
GRANT SELECT ON wordpress.* TO 'wp_visitor'@'%';

-- Apply privileges
FLUSH PRIVILEGES;
