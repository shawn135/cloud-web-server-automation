import boto3
import os

# Variables
log_file = "/var/log/nginx/access.log"
s3_bucket = "shawn-webserver-backups"
s3_key = f"backups/access.log_{os.path.getmtime(log_file)}"

# Upload to S3
s3 = boto3.client('s3')
try:
    s3.upload_file(log_file, s3_bucket, s3_key)
    print(f"Backup complete: {log_file} uploaded to s3://{s3_bucket}/{s3_key}")
except Exception as e:
    print(f"Error uploading {log_file}: {e}")