FROM mariadb:11.4

# Load env vars
source /var/www/html/.env

# Replace env vars in the SQL file and execute
envsubst < /docker-entrypoint-initdb.d/init.sql | mariadb -h mariadb -u root -p"$DB_ROOT_PASSWORD"

COPY ./tools/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

