resource "aws_db_instance" "createRDS" {
  allocated_storage          = "${local.disk_size}"
  engine                     = "${var.engine}"
  engine_version             = "${var.engine_version}"
  identifier                 = "${local.rdsid}"
  instance_class             = "${local.instance_type}"
  storage_type               = "${local.gp2}"
  password                   = "${local.password}"
  name                       = "${var.database}"
  username                   = "${local.username}"
  skip_final_snapshot        = "${var.skip_final_snapshot}"
  multi_az                   = "${local.multi_az}"
  port                       = "${var.databasePort}"
  vpc_security_group_ids     = ["${aws_security_group.sg3.id}"]
  db_subnet_group_name       = "${aws_db_subnet_group.default.name}"
  #parameter_group_name       = "${var.parameter_group_name}"
  storage_encrypted          = "${local.storage_encrypted}"
  enabled_cloudwatch_logs_exports = "${local.logs_set}"
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-${var.project}-db-subnet-group-${var.region}"
  subnet_ids = ["${data.aws_subnet.subnet-selected1.id}","${data.aws_subnet.subnet-selected2.id}"]
}

