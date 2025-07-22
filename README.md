# cloud-web-server-automation

Cloud Web Server Automation
This project automates the setup of a secure web server on an Ubuntu VM, installing Nginx, PHP, MySQL, SSL (via Let’s Encrypt), and firewall rules. It’s designed for reliability and modularity, with CI/CD integration for testing.
Prerequisites

Ubuntu 20.04 or 22.04
Root or sudo access
Internet access for package downloads
Domain name (for SSL setup)

Usage

Clone the repository:git clone https://github.com/shawn135/cloud-web-server-automation.git
cd cloud-web-server-automation


Create config.ini with your settings:DOMAIN=example.com
PHP_VERSION=8.1


Run the script:sudo bash setup.sh


Verify setup by accessing http://<your-domain>/test.php.

Features

Modular Bash script with error handling and logging
Configurable via config.ini for flexibility
Automated SSL setup with Let’s Encrypt
Firewall configuration with UFW
CI/CD pipeline with GitHub Actions for automated testing

Project Structure

setup.sh: Main automation script
config.ini: Configuration file for customizable settings
.github/workflows/test.yml: GitHub Actions workflow for CI/CD

Notes

Logs are written to /var/log/web-server-setup.log.
Ensure port 443 is open for SSL.
