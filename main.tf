terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 3.0"
   }
 }
 required_version = ">= 1.2.0"
}

provider "aws" {
 region = "eu-central-1"
}

resource "aws_instance" "myec2" {
 ami = "ami-04c522ee4750da4dc"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["sg-09c59443e4e37de04"]
 tags = {
   name = "Demo System"
 }
}

# Виведення публічної IP-адреси
output "public_ip" {
  value       = aws_instance.myec2.public_ip
  description = "Public IP address of the created instance"
}

# Виведення приватної IP-адреси
output "private_ip" {
  value       = aws_instance.myec2.private_ip
  description = "Private IP address of the created instance"
}




