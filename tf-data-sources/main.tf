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


# AWS account details 

data "aws_caller_identity" "name"{

}

data "aws_region" "name" {

}

output "caller_info" {
  value = data.aws_caller_identity.name
}

output "region_name" {
  value = data.aws_region.name
}


# AWS ami id's

data "aws_ami" "name" {
    most_recent = true
    owners = [ "amazon" ]
}

output "aws_ami" {
  value = data.aws_ami.name.id
}


# AWS AZ's

data "aws_availability_zones" "names"{
    state = "available"
}

output "aws_zones" {
  value = data.aws_availability_zones.names
}


# AWS sg's

data "aws_security_group" "name" {
    tags = {
        mywebserver = "http"
    }
}

output "security_group" {
  value = data.aws_security_group.name.id
}


# AWS VPC's

data "aws_vpc" "name" {
    tags = {
        ENV = "PROD"
        Name = "my-vpc"
    }
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}


resource "aws_instance" "myserver" {
    ami = data.aws_ami.name.id
    instance_type = "t3.micro"

    tags = {
        Name = "data-server"
    }
}