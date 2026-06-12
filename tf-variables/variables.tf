
variable "aws_instance_type" {
  description = "Type of instance you want"
  type = string
  validation {
    condition = var.aws_instance_type=="t3.micro" || var.aws_instance_type=="t2.micro"
    error_message = "only t3.micro and t2.micro are allowed"
  }
}

variable "root_volume_size" {
  description = "volume size for instance"
  type = number
  default = 20
}

variable "root_volume_type" {
  description = "volume size for instance"
  type = string
  default = "gp3"
}

variable "additional_tags" {
  type = map(string) #expecting key=value format
  default = {}
}