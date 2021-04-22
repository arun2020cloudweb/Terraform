data "aws_ami" "ecs_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["**"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
#  owners = [""] #
}


data "template_file" "user_data" {
  template = "${file("ecs-user-data.tpl")}"

  vars {
    cluster_name = "${var.cluster_name}"
    connectors_task_name = "${var.connectors_task_name}"
  }
}

resource "aws_launch_configuration" "ecs_lc" {
    name_prefix = "ecs-lc-"
    image_id = "ami-e3fbd290"
    instance_type = "${var.ecs_instance_type}"
    user_data = "${file("ecs-user-data.tpl")}"
    key_name = "${var.aws_key_name}"
    security_groups = ["${aws_security_group.rabbit_sg.id}"]
    associate_public_ip_address = false
    lifecycle {
        create_before_destroy = true
    }

    root_block_device {
        volume_type = "gp2"
        volume_size = "20"
    }
}
#.............................................................................................................................

resource "aws_autoscaling_group" "ecs_instance_as" {
    vpc_zone_identifier = ["${aws_subnet.eu-west-1b-private.id}"]
    name = "ecs-instance-as"
    max_size = "10"
    min_size = "1"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    force_delete = true
    #load_balancers = ["${aws_elb.rabbit_elb.id}"]
    #target_group_arns = ["${var.target_group_arn}"]
    launch_configuration = "${aws_launch_configuration.ecs_lc.name}"

    tag {
        key = "Name"
        value = "stage.ecs-instance"
        propagate_at_launch = true
    }
}
