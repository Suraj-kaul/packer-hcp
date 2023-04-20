packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  profile       = "default"
  ami_name      = "First-pkr-image-ubuntu-v2"
  instance_type = "t2.micro"
  source_ami    = "ami-0a695f0d95cefc163"
  region        = "us-east-2"
  ssh_username  = "ubuntu"
}

build {
  name    = "My-second-build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      
    ]
  }
  hcp_packer_registry {
    bucket_name = "learn-packer-hcp-golden-base-image"
    description = <<EOT
This is a golden image base built on top of ubuntu 20.04.
    EOT

    bucket_labels = {
      "hashicorp-learn" = "learn-packer-hcp-image",

    }
  }
}
