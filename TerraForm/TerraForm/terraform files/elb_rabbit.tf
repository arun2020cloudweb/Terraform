# Create a rabbitMQ load balancer -- classic load balancer

resource "aws_elb" "rabbit_elb" {
  name = "stage-rabbit-elb"
  internal = true
  subnets = ["${aws_subnet.eu-west-1b-private.id}", "${aws_subnet.eu-west-1c-private.id}"]

  listener {
    instance_port = 5672
    instance_protocol = "tcp"
    lb_port = 5672
    lb_protocol = "tcp"
  }

  listener {
    instance_port = 15672
    instance_protocol = "tcp"
    lb_port = 15672
    lb_protocol = "tcp"
#   ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:5672"
    interval = 30
  }

#  instances = ["${aws_autoscaling_group.rabbit_master_as.id}", "${aws_autoscaling_group.rabbit_slave_as.id}"]
#  cross_zone_load_balancing = true
#  idle_timeout = 400
#  connection_draining = true
#  connection_draining_timeout = 400

  tags {
    Name = "stage-rabbit-elb"
  }
}
