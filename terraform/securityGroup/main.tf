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
  vpc_id      = "vpc-090e04bf417aa8fb8"

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
  ami                         = "ami-0423e37adc439e9a8" #використай свою AMI
  instance_type               = "t2.micro"
  key_name                    = "testt"
  subnet_id                   = "subnet-0768fcc00d190b6d9" #використай свою
  vpc_security_group_ids      = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true

  tags = {
    Name = "Instance-Public"
    VPC  = "vpc-090e04bf417aa8fb8" #використай свою
  }
}

resource "aws_instance" "instance_2" {
  ami                    = "ami-0423e37adc439e9a8" #використай свою AMI
  instance_type          = "t2.micro"
  key_name               = "testt"
  subnet_id              = "subnet-099a75c13dd9cdb80" #використай свою 
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "Instance-Privat"
    VPC  = "vpc-090e04bf417aa8fb8" #використай свою
  }
}
