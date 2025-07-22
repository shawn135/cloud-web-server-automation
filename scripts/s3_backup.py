import boto3
import paramiko
import os

# Variables
ec2_ip = "3.94.198.204"
ssh_key_path = "/home/shawn135/.ssh/shawn-key.pem"
ssh_user = "ubuntu"
log_file = "/var/log/nginx/access.log"
s3_bucket = "shawn-webserver-backups"
s3_key = "backups/access.log"

# SSH into EC2 and download log file
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(ec2_ip, username=ssh_user, key_filename=ssh_key_path)

sftp = ssh.open_sftp()
sftp.get(log_file, "access.log")
sftp.close()
ssh.close()

# Upload to S3
s3 = boto3.client('s3')

s3.upload_file("access.log", s3_bucket, s3_key)

print("Backup complete: access.log uploaded to S3")
