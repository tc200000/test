terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}


resource "aws_security_group" "ssh_access" {
  name        = "ssh-access-sg"
  description = "Allow SSH access to EC2 instances"
  vpc_id      = "vpc-05a7241fa0102451a"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH Access Security Group"
  }
}


resource "aws_instance" "instance_1" {
  ami                         = "ami-0c30057a68c2aeddb" #використай свою AMI
  instance_type               = "t2.micro"
  key_name                    = "testt"
  subnet_id                   = "subnet-0128ae2179f032b24" #використай свою
  vpc_security_group_ids      = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true

  tags = {
    Name = "Instance-Public"
    VPC  = "vpc-05a7241fa0102451a" #використай свою
  }
}

resource "aws_instance" "instance_2" {
  ami                    = "ami-0c30057a68c2aeddb" #використай свою AMI
  instance_type          = "t2.micro"
  key_name               = "testt"
  subnet_id              = "subnet-036b1511c868456e4" #використай свою 
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "Instance-Privat"
    VPC  = "vpc-05a7241fa0102451a" #використай свою
  }
}
