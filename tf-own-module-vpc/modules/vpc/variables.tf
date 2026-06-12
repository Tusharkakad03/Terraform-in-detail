variable "vpc_config" {
    description = "To get the CIDR and Name of VPC from the user"
    type = object({
      cidr_block = string
      name = string 
    })
}