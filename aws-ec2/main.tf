terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
  }
}

provider "aws" {
    region = var.region
}


resource "aws_instance" "myserver" {

    ami = "ami-0fe18bc3cfa53a248"
    instance_type = "t3.micro"

    tags = {
        Name = "SampleServer"
    }
  
}