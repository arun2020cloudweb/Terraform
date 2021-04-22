resource "aws_db_instance" "rds_instance" {
  depends_on             = ["aws_security_group.db_sg"]
  identifier             = "${var.identifier}"
  allocated_storage      = "${var.storage}"
  engine                 = "${var.engine}"
  engine_version         = "${lookup(var.engine_version, var.engine)}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.db_name}"
  username               = "${var.username}"
  password               = "${var.password}"
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.dbsubnet.id}"
}

resource "aws_db_subnet_group" "dbsubnet" {
  name        = "db_subnet_group"
  description = "Our db  subnets"
  subnet_ids  = ["${aws_subnet.eu-west-1a-public.id}", "${aws_subnet.eu-west-1b-private.id}", "${aws_subnet.eu-west-1c-private.id}"]
}
