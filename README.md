# ☁️ Cloud Web Server Automation

This project automates the deployment of a fully functional LAMP-style web server (Nginx, MySQL, PHP) on an AWS EC2 instance using **Terraform** and **Ansible**, with **GitHub Actions** providing full CI/CD integration.

---

## 🚀 Features

- **Terraform** provisions:
  - EC2 instance
  - Security groups
  - Key pair

- **Ansible** configures:
  - Installs NGINX, MySQL, PHP
  - Replaces default index page
  - Hardens SSH config

- **GitHub Actions** handles:
  - CI/CD on push
  - Optional test validation with `curl`
  - Seamless deploy pipeline

---

## 📁 Folder Structure

├── .github/workflows/
│ ├── deploy.yml # CI/CD pipeline
│ └── test.yml # Optional test validation
├── ansible/
│ └── setup-nginx.yml # Ansible playbook
├── terraform/
│ └── main.tf # Infrastructure definition
├── setup.sh # Local bootstrap script
├── test.php # PHP info page (optional)
└── README.md


---

## 🛠️ How to Use

### ✅ Prerequisites

- AWS account & credentials
- Terraform installed
- SSH private key (e.g., `key.pem`)
- GitHub Actions secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

---

### 1. Clone the Repo

```bash
git clone https://github.com/your-username/cloud-web-server-automation.git
cd cloud-web-server-automation

Deploy Infrastructure
cd terraform
terraform init
terraform apply

ansible-playbook -i <your-ec2-ip>, ansible/setup-nginx.yml --user ubuntu --private-key your-key.pem

👨‍💻 Author
Shawn [@shawn135]

Cloud Engineer • Bartender • Fitness Nerd
Building beautiful infra with scripts and swagger.

🧠 Notes
SSH root login is disabled for security

Terraform state is stored locally

NGINX and PHP services are auto-started

Use setup.sh for manual local installs

