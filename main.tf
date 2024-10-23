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
    ami = "ami-0c1c30571d2dae5c9"

    # What type of instance to launch - t2.micro
    instance_type = "t2.micro"

    # Add a public IP to this instance
    associate_public_ip_address = true

    # Name the service/resource we create
    tags = {
        Name = "tech264-kagan-tf-app-instance"
    }
}




