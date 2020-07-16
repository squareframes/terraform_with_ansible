#RDS Outputs
output "password" {
  sensitive   = true
  description = "RDS master password"
  value       = "${local.password}"
}

output "username" {
  description = "DB master user name"
  value       = "${local.username}"
}

output "address" {
  description = "The address of the RDS instance."
  value       = "${aws_db_instance.createRDS.address}"
}

output "database" {
  description = "The database name."
  value       = "${var.database}"
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)."
  value       = "${aws_db_instance.createRDS.hosted_zone_id}"
}

output "rds_id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.createRDS.id}"
}


