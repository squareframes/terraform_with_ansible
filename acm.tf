data "aws_acm_certificate" "cert" {
  domain   = ${var.domainName}
  statuses = ["ISSUED"]
}