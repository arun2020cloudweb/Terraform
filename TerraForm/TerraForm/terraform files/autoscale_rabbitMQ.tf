data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn-ami-hvm-2016.09.1.20161221-x86_64-gp2*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
#  owners = [""] #
}



resource "aws_launch_configuration" "rabbit_lc" {
    name_prefix = "rabbit-lc-"
    image_id = "${data.aws_ami.ubuntu.id}"
    instance_type = "${var.rabbit_instance_type}"
    user_data = "${file("init-rabbitMQ.sh")}"
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

resource "aws_autoscaling_group" "rabbit_master_as" {
    vpc_zone_identifier = ["${aws_subnet.eu-west-1b-private.id}"]
    name = "rabbit-ac"
    max_size = "10"
    min_size = "1"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    force_delete = true
    load_balancers = ["${aws_elb.rabbit_elb.id}"]
    launch_configuration = "${aws_launch_configuration.rabbit_lc.name}"

    tag {
        key = "Name"
        value = "stage.Rabbit-master"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_group" "rabbit_slave_as" {
    vpc_zone_identifier = ["${aws_subnet.eu-west-1c-private.id}"]
    name = "rabbit-slave-ac"
    max_size = "10"
    min_size = "1"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    force_delete = true
    load_balancers = ["${aws_elb.rabbit_elb.id}"]
    launch_configuration = "${aws_launch_configuration.rabbit_lc.name}"

    tag {
        key = "Name"
        value = "stage.Rabbit-slave"
        propagate_at_launch = true
    }
}
#................................................................................................................................

resource "aws_autoscaling_policy" "master-scale-up" {
    name = "rabbit-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.rabbit_master_as.name}"
}

resource "aws_autoscaling_policy" "master-scale-down" {
    name = "rabbit-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.rabbit_master_as.name}"
}

resource "aws_autoscaling_policy" "slave-scale-up" {
    name = "rabbit-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.rabbit_slave_as.name}"
}

resource "aws_autoscaling_policy" "slave-scale-down" {
    name = "rabbit-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.rabbit_slave_as.name}"
}

#..................................................................................................................................

resource "aws_cloudwatch_metric_alarm" "rabbit_master-memory-high" {
    alarm_name = "rabbit_master-mem-util-high-agents"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This metric monitors ec2 memory for high utilization on  hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.master-scale-up.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.rabbit_master_as.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "rabbit_master-memory-low" {
    alarm_name = "rabbit_master-mem-util-low-agents"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "40"
    alarm_description = "This metric monitors ec2 memory for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.master-scale-down.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.rabbit_master_as.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "rabbit_slave-memory-high" {
    alarm_name = "rabbit_slave-mem-util-high-agents"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This metric monitors ec2 memory for high utilization on  hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.slave-scale-up.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.rabbit_slave_as.name}"
    }
}

resource "aws_cloudwatch_metric_alarm" "rabbit_slave-memory-low" {
    alarm_name = "rabbit_slave-mem-util-low-agents"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "40"
    alarm_description = "This metric monitors ec2 memory for low utilization on agent hosts"
    alarm_actions = [
        "${aws_autoscaling_policy.slave-scale-down.arn}"
    ]
    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.rabbit_slave_as.name}"
    }
}



