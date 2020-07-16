resource "aws_security_group" "sg1" {
  name = "elb_app_sg"
  description = "Allow inbound traffic as Per Resource/Requirement"
  vpc_id = "${data.aws_subnet.subnet-selected1.vpc_id}"
  revoke_rules_on_delete = "true"
    ingress {
    cidr_blocks = ["${data.aws_subnet.subnet-selected3.cidr_block}","${data.aws_subnet.subnet-selected4.cidr_block}"]
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["${var.ansibleServer}"]
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
  }
    egress {
    cidr_blocks = ["0.0.0.0/32"]
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
  }
    egress {
    cidr_blocks = ["0.0.0.0/32"]
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
  }

    egress {
    cidr_blocks = ["${data.aws_subnet.subnet-selected3.cidr_block}","${data.aws_subnet.subnet-selected4.cidr_block}"]
    from_port   = "${var.databasePort}"
    to_port     = "${var.databasePort}"
    protocol    = "tcp"
  }

}

resource "aws_security_group" "sg3" {
    name  ="${var.project}-rds-${var.region}"
    description="${var.project}-rds-${var.region}"
    vpc_id = "${data.aws_subnet.subnet-selected1.vpc_id}"
    ingress {
    cidr_blocks = ["${data.aws_subnet.subnet-selected3.cidr_block}","${data.aws_subnet.subnet-selected4.cidr_block}"]
    from_port   = "${var.databasePort}"
    to_port     = "${var.databasePort}"
    protocol    = "tcp"
  }
      tags = "${merge(
    map(
      "Name", "sg-${var.project}-rds-${var.region}",
      "product", "sg-${var.project}-rds-${var.region}"
    )
  )}"
}


resource "aws_security_group" "lb_sg" {
    name  ="${var.project}-lb-sg-${var.region}"
    description="${var.project}-lb-sg-${var.region}"
    vpc_id = "${data.aws_subnet.subnet-selected1.vpc_id}"
    ingress {
    cidr_blocks = ["103.204.38.58/32"]
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
  }
    egress {
    cidr_blocks = ["${data.aws_subnet.subnet-selected3.cidr_block}","${data.aws_subnet.subnet-selected4.cidr_block}"]
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
  }
      tags = "${merge(
    map(
      "Name", "sg-${var.project}-lb-sg-${var.region}",
      "product", "sg-${var.project}-lb-sg-${var.region}"
    )
  )}"
}