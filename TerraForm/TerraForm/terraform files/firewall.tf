resource "aws_security_group" "db_sg" {
  name = "${var.db_sg}"
  description = "db  access firewall rule"
  vpc_id = "${aws_vpc.stage.id}"
  ingress {
      from_port = 5432
      to_port = 5432
      protocol = "tcp"
      cidr_blocks = ["54.229.116.182/32"]
  }
  
  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

  tags {
    Name = "${var.db_sg}"
  }
}




resource "aws_security_group" "rabbit_sg" {
  name = "${var.rabbit_sg}"
  description = "rabbit  access firewall rule"
  vpc_id = "${aws_vpc.stage.id}"
  ingress {
      from_port = 5672
      to_port = 5672
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 15672
      to_port = 15672
      protocol = "tcp"
      cidr_blocks = ["54.229.116.182/32"]
  }

  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

  tags {
    Name = "${var.rabbit_sg}"

  }
}
