-- Select the database to use (created via MYSQL_DATABASE)
USE wordpress;

-- Admin user (must NOT contain "admin" in any form)
CREATE USER 'gyong-si'@'%' IDENTIFIED BY 'ivangoh123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'gyong-si'@'%';

-- Normal user
CREATE USER 'visitor'@'%' IDENTIFIED BY 'visitor_pass';
GRANT SELECT ON wordpress.* TO 'visitor'@'%';

-- Apply privileges
FLUSH PRIVILEGES;
