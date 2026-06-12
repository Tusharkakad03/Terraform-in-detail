terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
  }
  backend "s3" {
    bucket = "terra-bucket-22adfdebbbae3612"
    key = "backend.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "myserver" {

    ami = "ami-0fe18bc3cfa53a248"
    instance_type = "t3.micro"

    tags = {
        Name = "SampleServer"
    }
  
}