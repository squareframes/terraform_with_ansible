#VPC
variable "private_subnet_id_1" {
    default=""
  
}

variable "private_subnet_id_2" {
    default=""
  
}

variable "public_subnet_id_1" {
    default=""
  
}

variable "public_subnet_id_2" {
    default=""
  
}


#EC2
variable "environmentName"{
    default="test"
}


variable "region"{
    default="us-east-1"
}

variable "ubuntu_user"{
    default="ubuntu"
}


variable "project"{
    default="test"
}

#SCM
variable "domainName" {
  default = "*.squareframestechnology.com"
}


#Key-Pair
variable "public_key" {
  default = "~/terraform/elb-app-deploymnet/data/id_rsa.pub"
}
variable "private_key" {
  default = "~/terraform/elb-app-deploymnet/data/id_rsa"
}