terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
  }
}

provider "aws" {
    region = "us-east-2"
}


locals {
    owner = "ABC"
    name = "MYSERVER"
}

resource "aws_instance" "myserver" {

    ami = "ami-0fe18bc3cfa53a248"
    instance_type = var.aws_instance_type

    root_block_device {
        delete_on_termination = true
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
    }

    tags = {
        Name = local.name
    }
  
}