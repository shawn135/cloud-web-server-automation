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

log "Setup completed successfully"