FROM alpine:latest

# Install nginx and openssl
RUN apk update && apk add nginx openssl

# Create the folders
RUN mkdir -p /etc/nginx/ssl /run/nginx

# Generate the self signed certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/gyong-si.42.fr.key \
  -out /etc/nginx/ssl/gyong-si.42.fr.crt \
  -subj "/C=SG/ST=State/L=City/O=School/OU=42/CN=gyong-si.42.fr"

# Expose HTTPS port
EXPOSE 443

# Run NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]