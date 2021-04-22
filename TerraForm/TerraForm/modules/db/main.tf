resource "aws_db_instance" "rds_instance" {
  identifier             = "${var.identifier}"
  allocated_storage      = "${var.storage}"
  engine                 = "${var.engine}"
  engine_version         = "${lookup(var.engine_version, var.engine)}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.db_name}"
  username               = "${var.username}"
  password               = "${var.password}"
  vpc_security_group_ids = ["${var.security_group_db_sg}"]
  db_subnet_group_name   = "${aws_db_subnet_group.dbsubnet.id}"
}

resource "aws_db_subnet_group" "dbsubnet" {
  name        = "db_subnet_group"
  description = "Our db  subnets"
  subnet_ids  = ["${split(",", var.db_subnet_ids)}"]
}