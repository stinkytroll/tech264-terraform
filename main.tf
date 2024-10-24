# Create an EC2 instance
# aws_access_key = (key) MUST NEVER DO THIS
# aws_secret_key =(secret key) MUST NEVER DO THIS
# Where to create - provide the provider

# Syntax often used in HCL is key = value
provider "aws" {
  # Which region to use to create infrastructure
  region = "eu-west-1"
}

# Which service / resources to create
resource "aws_instance" "app_instance" {
  # Which AMI ID: AMI ID ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
  ami = var.app_ami_id

  # What type of instance to launch - t2.micro
  instance_type = var.instance_type

  # Add a public IP to this instance
  associate_public_ip_address = true

  # Attach the key pair to be used for SSH
  key_name = var.my_super_duper_secret_key # Replace with your actual key pair name

  vpc_security_group_ids = [aws_security_group.tech264_kagan_sg.id]

  # Name the service/resource we create
  tags = {
    Name = "tech264-kagan-tf-app-instance"
  }
}

resource "aws_security_group" "tech264_kagan_sg" {
  name        = "tech264-kagan-tf-allow-port-22-3000-80"
  description = "Security group allowing SSH, HTTP and app traffic"

  # Allow SSH (port 22) from localhost
  # Allow SSH (port 22) from localhost
  ingress {
    description = "Allow SSH from localhost"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
  }

  # Allow HTTP (port 80) from all
  ingress {
    description = "Allow HTTP from all"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
  }

  # Allow application traffic (port 3000) from all
  ingress {
    description = "Allow App traffic from all"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = var.public_cidr_block
  }

  tags = {
    Name = "tech264-kagan-tf-allow-port-22-3000-80"
  }
}

