data "aws_subnet" "subnet-selected1" {
    id ="${var.private_subnet_id_1}"
  
}
data "aws_subnet" "subnet-selected2" {
  id="${var.private_subnet_id_2}"
}

data "aws_subnet" "subnet-selected3"{
    id="${var.public_subnet_id_1}"
}

data "aws_subnet" "subnet-selected4"{
    id="${var.public_subnet_id_2}"
}