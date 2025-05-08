terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a SSH Key Pair
resource "aws_key_pair" "fintrack" {
  key_name   = "fintracker_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create a Security Group
resource "aws_security_group" "fintrack" {
  name        = "fintracker_sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
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


# Create an EC2 Instance
resource "aws_instance" "fintrack" {
  ami           = "ami-084568db4383264d4" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  key_name      = aws_key_pair.fintrack.key_name
  security_groups = [
    aws_security_group.fintrack.name
  ]

  user_data = file("${path.module}/scripts/user-data.sh")

  tags = {
    Name = "fintracker_instance"
  }
}

