resource "aws_lb" "albapp" {
  name               = "app-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["${data.aws_subnet.subnet-selected3.id}","${data.aws_subnet.subnet-selected4.id}"]

  enable_deletion_protection = true

  tags = {
    Environment = "test"
  }
}


# Port 443

resource "aws_alb_listener" "apt_https" {
  load_balancer_arn = tostring("${aws_lb.albapp.arn}")
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn = "${data.aws_acm_certificate.cert.arn}"


  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.web_http.arn}"
  }
  depends_on = [aws_lb.albapp]
}

resource "aws_lb_target_group" "web_http" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.aws_subnet.subnet-selected1.vpc_id}"
  target_type = "instance"
    health_check {
    path = "/index.php"
    port = 80
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

resource "aws_lb_target_group_attachment" "apt_http" {
  target_group_arn = "${aws_lb_target_group.web_http.arn}"
  target_id        = "${aws_instance.launchEC2.id}"
  port             = 80
}





