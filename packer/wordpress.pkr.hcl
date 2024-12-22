packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}


locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "wpTest3"
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

      "export DEBIAN_FRONTEND=noninteractive",
      "sudo add-apt-repository universe -y",

      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
     
      "sudo apt-get install -y apache2",
      "echo 'Hello World' | sudo tee /var/www/html/index.html",
      "sudo systemctl enable apache2"
    ]
  }
}





