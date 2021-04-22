# Application load balancer that distributes load between the instances
resource "aws_alb" "alb" {
  name = "system-services-alb"
  internal = false

  security_groups = [
    "${var.security_group_internal_id}",
    "${var.security_group_inbound_id}",
  ]

  subnets = ["${split(",", var.alb_subnet_ids)}"]
}


resource "aws_alb" "api_alb" {
  name = "api-system-services-alb"
  internal = false

  security_groups = [
    "${var.security_group_internal_id}",
    "${var.security_group_inbound_id}",
  ]

  subnets = ["${split(",", var.alb_subnet_ids)}"]
}
#.............................................................................................
# Default ALB target group that defines the default port/protocol the instances will listen on
#.............................................................................................
resource "aws_alb_target_group" "tg" {
  name = "system-services-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/"
  }
}
resource "aws_alb_target_group" "admin_tg" {
  name = "administration-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/administration/doc/"
    port = "8082"
  }
}

resource "aws_alb_target_group" "auth_tg" {
  name = "authentication-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/authentication/doc/"
    port = "8989"
  }
}

resource "aws_alb_target_group" "login_tg" {
  name = "login-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/login/"
    port = "3000"
  }
}
resource "aws_alb_target_group" "cm_tg" {
  name = "client-manager-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/client-manager/"
    port = "3002"
  }
}

resource "aws_alb_target_group" "sm_tg" {
  name = "system-manager-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/system-manager/"
    port = "9000"
  }
}
#........................
resource "aws_alb_target_group" "api_auth_tg" {
  name = "api-authentication-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/authentication/doc/"
    port = "8989"
  }
}

resource "aws_alb_target_group" "api_admin_tg" {
  name = "api-administration-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/administration/doc/"
    port = "8082"
  }
}

resource "aws_alb_target_group" "api_cm_tg" {
  name = "api-clientmgnt-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/client-management/doc/"
    port = "6080"
  }
}

resource "aws_alb_target_group" "api_ss_tg" {
  name = "api-systemservices-tg"
  protocol = "HTTP"
  port = "80"
  vpc_id = "${var.vpc_id}"

  health_check {
    path = "/system-services/doc/"
    port = "90"
  }
}
#.................................................................................................
# ALB listener that checks for connection requests from clients using the port/protocol specified
# These requests are then forwarded to one or more target groups, based on the rules defined
#................................................................................................
resource "aws_alb_listener" "instance_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = "80"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:eu-west-1:045420858749:certificate/383f5a0a-c841-4863-a966-a206a4100aaa"

  default_action {
    target_group_arn = "${aws_alb_target_group.tg.arn}"
    type = "forward"
  }

  depends_on = ["aws_alb_target_group.tg"]
}

