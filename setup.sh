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

# Start and enable services
systemctl enable nginx
systemctl start nginx
check_error "Failed to start Nginx"

systemctl enable php8.1-fpm  # Adjust version as needed
systemctl start php8.1-fpm
check_error "Failed to start PHP-FPM"

# Configure Nginx to handle PHP
log "Configuring Nginx for PHP..."
cat > /etc/nginx/sites-available/default << 'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# Test and reload Nginx configuration
nginx -t
check_error "Nginx configuration test failed"

systemctl reload nginx
check_error "Failed to reload Nginx"

# Harden SSH
log "Hardening SSH..."
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh
check_error "Failed to harden SSH"

# Create test PHP file
echo "<?php phpinfo(); ?>" > /var/www/html/test.php
chown www-data:www-data /var/www/html/test.php
chmod 644 /var/www/html/test.php

# Wait a moment for services to be ready
sleep 2

log "Setup completed successfully"