terraform {
 backend "s3" {
 encrypt = true
 bucket = ""  #bucket Name
 dynamodb_table = "terraform-state-lock-dynamo" #dynamodb_table Name
 region = "us-east-1"
 key = "test-alb-app/terraform.tfstate" #bucket key Name
 }
}