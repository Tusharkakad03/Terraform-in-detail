terraform {}

# Number List 
variable "num_list" {
  type = list(number)
  default = [ 1,2,3,4,5 ]
}

# Object list of person
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [ {
    fname = "Raju"
    lname = "Rastogi"
  },{
    fname = "Sham"
    lname = "Paul"
  } ]
}

# Map List 
variable "map_list" {
  type = map(number)
  default = {
    "one" = 1
    "two" = 2
    "three" = 3
  }
}


# Calculations 

locals {
  mul = 2*8
  add = 2+2
  eq = 2 != 3

  #double the list 
  double = [for num in var.num_list: num*2]

  #odd no. only
  odd = [for num in var.num_list: num if num % 2 != 0]

  #To get only fname from person list 
  fname_list = [for person in var.person_list: person.fname]

  #To get only fname from person list 
  lname_list = [for person in var.person_list: person.lname]

  #To get only keys form map list
  map_info = [for key, value in var.map_list : key]

  #To get only values form map list
  map_info1 = [for key, value in var.map_list : value*5]

  #double the value
  double_map = {for key, value in var.map_list : key => value * 2 }

}

output "output" {
#   value = local.eq
#   value = local.doubl
#   value = local.fname_list
    # value = local.map_info1

    value = local.double_map

}

# output "answer" {
#   value = var.num_list
# }

