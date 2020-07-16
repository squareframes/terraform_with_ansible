# terraform_assignment
deploy infrastructure using terraform and configuration using ansible

In this terraform code we are going to create following resources

1. EC2 -Ubuntu
2. RDS
3. ELB - Inetrnet facing
4. Taget -Ec2 instances

vpc.tf
	get subnt details using data.
	two private subnets
	two public
	
	we can provide subnets ids in inputvariables.tfvars
	
scm.tf
	We are using exiting cert for ELB
	
terraform_config.tf
	we config tfstate file on s3 bucket
	
ec2.tf
	launch instance and use local-exec to run ansible playbook

