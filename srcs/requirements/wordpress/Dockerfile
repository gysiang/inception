# Copy script
COPY script.sh /usr/local/bin/script.sh
COPY .env /var/www/html/.env

# Make it executable
RUN chmod +x /usr/local/bin/script.sh

# Set working dir
WORKDIR /var/www/html

# Expose port
EXPOSE 9000

# Use custom entrypoint
ENTRYPOINT ["/usr/local/bin/script.sh"]
