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
    users_data = yamldecode(file("./users.yaml")).users

    user_role_pair = flatten([for user in local.users_data: [for role in user.roles: {
        username = user.username
        role = role
    }]])
}

output "output" {
  value = local.user_role_pair
}

# Creating IAM users
resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)  # list ot set convert 
  name = each.value
}

# Password creation 
resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [ 
        password_length,
        password_reset_required,
        pgp_key,
     ]
  }
}

# Attaching policies 
resource "aws_iam_user_policy_attachment" "main" {
  for_each = {
    for pair in local.user_role_pair:
    "${pair.username}-${pair.role}" => pair  
  }
  #baburao-EC2Access = {username = baburao, role = ec2access}
  #baburao-s3ready = {}

  user = aws_iam_user.users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"

}