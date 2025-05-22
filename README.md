# inception

##1. Project Setup

- [ ] Create a Virtual Machine for development.
- [ ] Set up the working directory structure:
</br>
.
├── Makefile</br>

├── secrets/</br>

├── srcs/</br>

    ├── docker-compose.yml
    ├── .env
    ├── requirements/
        ├── mariadb/
        ├── nginx/
        ├── wordpress/
        ├── bonus/ (optional)

##2. Mandatory Services

***Docker Compose & General Setup***
- [ ] Write Makefile to build and start the entire infrastructure using docker-compose.
- [ ] Create .env file for environment variables (DB credentials, domain name, etc.)
- [ ] Configure Docker network in docker-compose.yml.
- [ ] Ensure no use of network: host, --link, or links:.
- [ ] Ensure containers restart automatically on crash.

***NGINX Container***
- [ ] Use Alpine or Debian base image.
- [ ] Write custom Dockerfile.
- [ ] Set up HTTPS with only TLSv1.2 or TLSv1.3.
- [ ] Configure NGINX to act as reverse proxy on port 443 only.
- [ ] Prevent insecure patches like tail -f or sleep infinity.

***MariaDB Container***
- [ ] Use Alpine or Debian base image.
- [ ] Write Dockerfile to install and configure MariaDB.
- [ ] Create a volume for the database.
- [ ] Set up at least 2 users, with one as admin (username must not contain “admin” in any form).
- [ ] Store passwords using environment variables or secrets files (e.g. db_password.txt).

##3. Domain Configuration
- [ ] Set domain name to login.42.fr pointing to your local IP (e.g., wil.42.fr).
- [ ] Configure the domain in .env.

##4. Security Requirements
- [ ] Store credentials in the secrets/ directory.
- [ ] Do not hardcode passwords in Dockerfiles.
- [ ] Use Docker secrets for sensitive info.
- [ ] Do not use the latest Docker tag.

##5. Best Practices
- [ ] Follow PID 1 best practices (e.g., use tini or configure entrypoints properly).
- [ ] Avoid infinite loop commands (e.g., while true, bash, sleep infinity).

##6. Testing
- [ ] Test container auto-restart on crash.
- [ ] Verify all containers communicate via custom Docker network.
- [ ] Ensure HTTPS access through NGINX only.
- [ ]Verify database connection and WordPress installation via browser.

##7. Bonus Part (optional – only if mandatory is perfect)
- [ ] Add Redis container for WordPress caching.
- [ ] Add Adminer container for database management.
- [ ] Add FTP server container linked to the WordPress volume.
- [ ] Add a static site (non-PHP) served in a separate container.
- [ ] Add any useful custom service with proper justification.

##8. Submission
- [ ] Clean repository of sensitive data (e.g., add secrets/* to .gitignore).
- [ ] Submit everything via Git repository as per instructions.
- [ ] Double-check all file and folder names are correct.
