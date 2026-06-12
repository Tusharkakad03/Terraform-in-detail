module "aws_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  ami = "ami-0fe18bc3cfa53a248"
  instance_type = "t3.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id     = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}