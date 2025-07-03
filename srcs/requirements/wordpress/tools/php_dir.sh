#!/bin/bash
mkdir -p /run/php
chown -R www-data:www-data /run/php
chmod 755 /run/php

sudo chmod +x /usr/local/bin/create-run-php-dir.sh
sudo systemctl edit php8.2-fpm
ExecStartPre=/usr/local/bin/php-dir.sh

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart php8.2-fpm
