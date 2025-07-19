# cloud-web-server-automation

Cloud Web Server Automation 🚀
What This Is
This project automates the deployment of a cloud-based NGINX web server using:

Terraform – for AWS infrastructure provisioning

Ansible – for server configuration and deployment

It creates a VPC, EC2 instance, and security group, then installs NGINX and deploys a custom web page.

Tech Stack
Tool	Purpose
Terraform	Infrastructure as Code (EC2, VPC, Subnet, Security Group, Internet Gateway)
Ansible	Configuration management (NGINX install, web page deployment)
AWS	Cloud hosting (EC2 instance + networking)

How It Works
1️⃣ Terraform:

Provisions an EC2 instance

Sets up VPC, Subnet, and Internet Gateway

Configures Security Groups for SSH and HTTP

2️⃣ Ansible:

SSH into the EC2 instance

Installs NGINX

Deploys a simple custom HTML page

Usage
1. Clone the Repo
bash
Copy
Edit
git clone https://github.com/shawn135/cloud-web-server-automation.git
cd cloud-web-server-automation
2. Run Terraform
bash
Copy
Edit
cd terraform/
terraform init
terraform apply
Grab the EC2 public IP from Terraform output.

3. Update Ansible Inventory
In ansible/inventory.ini, replace:

ini
Copy
Edit
[web]
<YOUR_PUBLIC_IP> ansible_user=ubuntu ansible_ssh_private_key_file=/path/to/your/key.pem
4. Run Ansible
bash
Copy
Edit
cd ../ansible/
ansible-playbook -i inventory.ini setup-nginx.yml
5. View Your Web Server
Open a browser and go to:

cpp
Copy
Edit
http://<YOUR_PUBLIC_IP>
Screenshot (Optional)
If you want, take a screenshot of your deployed webpage and add:

markdown
Copy
Edit
![Screenshot](screenshot.png)
Why This Matters
This project mimics real-world DevOps and cloud automation workflows, including:

Infrastructure as Code (Terraform)

Configuration Management (Ansible)

Cloud provisioning (AWS EC2 & Networking)

Great for learning or for your DevOps portfolio.

Next Steps (Optional Enhancements)
Add New Relic / CloudWatch monitoring

Create a Python script to back up logs to S3

Expand to multi-server setup with load balancer

