packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.8"
    }
  }
}


locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "nginxHelloWorld"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  security_group_id = "sg-09c59443e4e37de04"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer2"
  sources = ["source.amazon-ebs.ubuntu"]


  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "echo '<!DOCTYPE html><html><head><title>Hello World</title></head><body><h1>Hello World</h1></body></html>' | su$      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}





