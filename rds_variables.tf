variable "nameRDS" {
  description = "A unique name of RDS instance"
}



variable "disk_size" {
  description = "The allocated storage in gibibytes."
  default     = "20"
}

variable "password" {
  description = "Password for the master DB user. Leave empty to generate."
  default     = ""
}

variable "username" {
  description = "Username for the master DB user. Leave empty to generate."
  default     = ""
}

variable "database" {
  description = "The name of the database to create when the DB instance is created."
  default     = ""
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible. Default is false."
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = 0
}

variable "enable_audit_log" {
  description = "Enable audit log."
  default     = false
}

variable "enable_error_log" {
  description = "Enable error log."
  default     = true
}

variable "enable_general_log" {
  description = "Enable general log."
  default     = true
}

variable "enable_slowquery_log" {
  description = "Enable slowquery log."
  default     = true
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
  default     = "05:00-07:00"
}

variable "instance_type" {
  description = "The instance type of the RDS instance"
  default     = "db.t2.small"
}



variable "engine" {
  default="mysql"
}


variable "engine_version" {
  description = "MySQL version. Default is 8.0"
  default     = 5.7
}

variable "databasePort" {
  default=3306
  
}


locals {
  family = "mysql${var.engine_version}"
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  default     = true
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate."
  default     = "default.mariadb10.2"
}
variable "storage_type" {
  default = "gp2"
}

variable "storage_encrypted" {
  default = true
}

variable "skip_final_snapshot" {
  default = true
}

variable "projectName" {
  default = "elb-app-project"
}

locals {
  project                 = "${var.projectName}"
  name                    = "${var.nameRDS}"
  rdsid                      = "${lower(replace(var.nameRDS, " ", "-"))}"
  subnet_group_name       = "${lower(replace(var.nameRDS, " ", "-"))}"
  username                = "${var.username == "" ? random_pet.username.id : var.username}"
  password                = "${var.password == "" ? random_string.password.result : var.password}"
  #database                = "${var.database == "" ? random_pet.db_name.id : var.database}"
  parameter_group_name    = "${var.parameter_group_name}"
  rds_with_param_group    = "${local.parameter_group_name == "" ? 0 : 1}"
  rds_without_param_group = "${local.parameter_group_name == "" ? 3 : 0}"
  instance_type           = "${var.instance_type}"
  engine_version          = "${var.engine_version}"
  disk_size               = "${var.disk_size}"
  multi_az                = "${var.multi_az}"
  backup_window           = "${var.backup_window}"
  gp2                     ="${var.storage_type}"
  storage_encrypted       ="${var.storage_encrypted}"
  backup_retention_period = "${var.backup_retention_period}"
  publicly_accessible     = "${var.publicly_accessible}"
  apply_immediately       = "${var.apply_immediately}"
  trusted_cidr_blocks     = ["${data.aws_subnet.subnet-selected1.id}","${data.aws_subnet.subnet-selected2.id}"]
  db_subnets              = ["${data.aws_subnet.subnet-selected1.id}","${data.aws_subnet.subnet-selected2.id}"]
  #address                 = "${local.parameter_group_name == "" ? join("", aws_db_instance.createRDSInstance.*.address) : join("", aws_db_instance.createRDSInstanceParameterized.*.address)}"
  #hosted_zone_id          = "${var.parameter_group_name == "" ? join("", aws_db_instance.createRDSInstance.*.hosted_zone_id) : join("", aws_db_instance.createRDSInstanceParameterized.*.hosted_zone_id)}"
  #rds_id                  = "${var.parameter_group_name == "" ? join("", aws_db_instance.createRDSInstance.*.id) : join("", aws_db_instance.createRDSInstanceParameterized.*.id)}"

  logs_set                = "${compact(list(
    "${var.enable_audit_log ? "audit" : "" }",
    "${var.enable_error_log ? "error" : "" }",
    "${var.enable_general_log ? "general" : "" }",
    "${var.enable_slowquery_log ? "slowquery" : "" }"
  ))}"
}
