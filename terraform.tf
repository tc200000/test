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
 ami = "ami-067e8d934c362b31e"
 instance_type = "t2.micro"

# Додаємо Security Group ID
 vpc_security_group_ids = ["sg-09c59443e4e37de04"]

 tags = {
   name = "Demo System"
 }
}
