# AWS Cloud Web Server Automation

Automated deployment and configuration of an AWS web server using
Terraform, Ansible, and GitHub Actions.

## Overview

This project demonstrates Infrastructure as Code and automated
configuration management by provisioning an AWS EC2 web server
and deploying a NGINX/PHP/MySQL application stack.

The entire deployment process can be automated through GitHub Actions.

## Architecture

GitHub
   ↓
GitHub Actions
   ↓
Terraform
   ↓
AWS EC2
   ↓
Ansible
   ↓
NGINX + PHP + MySQL

## Technologies

- AWS EC2
- Terraform
- Ansible
- GitHub Actions
- NGINX
- PHP
- MySQL
- Linux
- Bash

## What I Built

### Infrastructure

Terraform provisions:

- EC2 instance
- Security group
- SSH key configuration

### Configuration Management

Ansible automatically:

- Installs NGINX
- Installs PHP
- Installs MySQL
- Configures the web server
- Deploys the application
- Applies SSH hardening

### CI/CD

GitHub Actions automates:

- Infrastructure deployment
- Configuration
- Deployment validation
- HTTP testing

## Engineering Practices

- Infrastructure as Code
- Automated configuration management
- CI/CD
- SSH hardening
- Automated deployment validation
- Separation of infrastructure and configuration

Lessons Learned

This project helped me understand how Terraform,
Ansible, and CI/CD tools can work together to automate
cloud infrastructure rather than manually configuring
servers.

Future Improvements
Replace static infrastructure with a VPC architecture
Add load balancing
Add Auto Scaling
Add CloudWatch monitoring
Use AWS Secrets Manager
Implement remote Terraform state
