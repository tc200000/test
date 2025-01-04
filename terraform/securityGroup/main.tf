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
  vpc_id      = "vpc-03fbe6190ee4199fe"

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
  ami                         = "ami-0bd77c19efc3ffadf" #використай свою AMI
  instance_type               = "t2.micro"
  key_name                    = "testt"
  subnet_id                   = "subnet-0ec8c0913d81b7307" #використай свою
  vpc_security_group_ids      = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true

  tags = {
    Name = "Instance-Public"
    VPC  = "vpc-03fbe6190ee4199fe" #використай свою
  }
}

resource "aws_instance" "instance_2" {
  ami                    = "ami-0bd77c19efc3ffadf" #використай свою AMI
  instance_type          = "t2.micro"
  key_name               = "KOWO"
  subnet_id              = "subnet-08f69270b5963e47c" #використай свою 
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "Instance-Privat"
    VPC  = "vpc-03fbe6190ee4199fe" #використай свою
  }
}
