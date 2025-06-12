FROM alpine:latest

# Install dependencies
RUN apk update && apk add --no-cache nginx openssl

# Create directories
RUN mkdir -p /etc/nginx/ssl /var/www/html

# Generate SSL certificates (with explicit paths)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/gyong-si.42.fr.key \
    -out /etc/nginx/ssl/gyong-si.42.fr.crt \
    -subj "/C=SG/ST=Singapore/L=Singapore/O=42School/OU=42/CN=gyong-si.42.fr" \
    && chmod 644 /etc/nginx/ssl/gyong-si.42.fr.crt \
    && chmod 600 /etc/nginx/ssl/gyong-si.42.fr.key

# copy the custom config file
COPY ./conf/default /etc/nginx/nginx.conf

# Verify files exist
RUN ls -l /etc/nginx/ssl/

# Expose and run
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
