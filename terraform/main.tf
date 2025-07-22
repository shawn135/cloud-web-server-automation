provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

resource "aws_iam_role" "web_server_role" {
  name = "web-server-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "web_server_policy" {
  name = "web-server-policy"
  role = aws_iam_role.web_server_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
      Effect = "Allow"
      Resource = ["arn:aws:s3:::shawn-webserver-backups/*", "arn:aws:s3:::shawn-webserver-backups"]
    }]
  })
}

resource "aws_iam_instance_profile" "web_server_profile" {
  name = "web-server-profile"
  role = aws_iam_role.web_server_role.name
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 AMI
  instance_type = "t2.micro"
  key_name      = "shawn-key"
  iam_instance_profile = aws_iam_instance_profile.web_server_profile.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow SSH, HTTP, and HTTPS"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"] # Replace with your IP (e.g., 192.168.1.1/32)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "web-server-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Triggers when CPU utilization exceeds 80% for 10 minutes"
  alarm_actions       = []
  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}