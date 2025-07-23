#!/bin/bash

# Initialize log file
LOG_FILE="/var/log/web-server-setup.log"
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Exit on error with message
check_error() {
    if [ $? -ne 0 ]; then
        log "ERROR: $1"
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

# Install PHP and MySQL
apt install -y php-fpm php-mysql mysql-server
check_error "Failed to install PHP or MySQL"

systemctl enable nginx
systemctl start nginx



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