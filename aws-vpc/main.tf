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


# Create a VPC 

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

# private subnet 

resource "aws_subnet" "private_subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "private-subnet"
    }
}

# public subnet 

resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my_vpc.id
  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway 

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "my-igw"
    }
}

# Route Table

resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }

    tags = {
      Name = "my-route-table"
    }
}

# Route table association 

resource "aws_route_table_association" "publiic_sub" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id = aws_subnet.public_subnet.id
}


# create ec2 instance 

resource "aws_instance" "myserver" {

    ami = "ami-0fe18bc3cfa53a248"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id

    tags = {
        Name = "VPC-server"
    }
}
