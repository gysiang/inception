From alpine:latest

RUN apk update %% apk add nginx openssl

# Create the folders
RUN mkdir -p /etc.nginx/ssl /run/nginx

# Copy SSL Cert and NGINX config
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./certs/yourdomain.crt / etc/nginx/ssl/yourdomain.crt
COPY ./certs/yourdomain.crt /etc/nginx/ssl/yourdomain.key

# Expose HTTPS port
EXPOSE 443

# Run NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]