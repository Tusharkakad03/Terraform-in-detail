terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }

    random = {
        source = "hashicorp/random"
        version = "3.6.2"
    }
  }
}

provider "aws" {
    region = "us-east-2"
}

resource "random_id" "rand_id" {
    byte_length = 8
}

resource "aws_s3_bucket" "demo_bucket" {
    bucket = "terra-bucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "bucket_data" {
    bucket = aws_s3_bucket.demo_bucket.bucket
    source = "./myfile.txt"
    key = "mydata.txt"
}

output "name" {
    value = random_id.rand_id.hex
}