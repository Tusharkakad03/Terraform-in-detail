provider "aws" {
  region = "us-east-2"
}

module "vpc" {
    source = "./modules/vpc"

    vpc_config = {
        cidr_block = "10.0.0.0/16"
        name = "my-test-vpc"
    }

}