#!/bin/bash

# Initialize log file
LOG_FILE="/var/log/web-server-setup.log"
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Exit on error with message and print service status if possible
check_error() {
    if [ $? -ne 0 ]; then
        log "ERROR: $1"
        systemctl status nginx || true
        if [ -n "$PHP_FPM_SERVICE" ]; then
            systemctl status "$PHP_FPM_SERVICE" || true
        fi
        exit 1
    fi
}

log "Starting web server setup..."

# Update package list
apt update -y
check_error "Failed to update package list"

# Install Nginx
apt install -y nginx
check_error "Failed to install Nginx"

systemctl enable nginx
systemctl start nginx
check_error "Failed to start Nginx"

# Install PHP and MySQL
apt install -y php-fpm php-mysql mysql-server
check_error "Failed to install PHP or MySQL"

# Find the installed php-fpm service and start it
PHP_FPM_SERVICE=$(systemctl list-unit-files | awk '/php.*-fpm.service/ {print $1; exit}')
if [ -n "$PHP_FPM_SERVICE" ]; then
    systemctl enable "$PHP_FPM_SERVICE"
    systemctl start "$PHP_FPM_SERVICE"
    check_error "Failed to start PHP-FPM"
else
    log "ERROR: No PHP-FPM service found"
    exit 1
fi

# Harden SSH
log "Hardening SSH..."
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh
check_error "Failed to harden SSH"

# Create test PHP file
echo "<?php phpinfo(); ?>" > /var/www/html/test.php
chown www-data:www-data /var/www/html/test.php
chmod 644 /var/www/html/test.php

log "Setup completed successfully"