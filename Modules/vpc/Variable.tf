variable "vpc_cider" {
    description = "passing the vpc cidr range"
    default = "10.3.0.0/16"
    type =  "string"
  
}

variable "vpc_name" {
  description = "passing the vpc_name"
  default = "stage"
  type = "string"

}

variable "pub_subnet_cird" {
    description = "pub subnet"  
    default = ["10.3.216.0/24","10.3.217.0/24","10.3.218.0/24","10.3.218.0/24" ]

}



variable "app_subnet_cird" { 
    description = "private subnet"  
    default = ["10.3.0.0/18","10.3.64.0/18","10.3.218.0/24","10.3.128.0/18" ]

}

variable "data_subnet_cidr" {
    description = " private subnet"
    default = ["10.3.192.0/21","10.3.200.0/21","10.3.208.0/21"]
  
}


#     cidr_block = "var.pub_subnet"

#   tags = {
#     Name = "var.pub_subnet"
#   }
# }
  
