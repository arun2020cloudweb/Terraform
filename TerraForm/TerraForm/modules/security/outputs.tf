output "internal_id" {
  value = "${aws_security_group.internal.id}"
}

output "inbound_id" {
  value = "${aws_security_group.inbound.id}"
}

output "ssh_id" {
  value = "${aws_security_group.ssh.id}"
}

output "db_sg_id" {
  value = "${aws_security_group.db_sg.id}"
}

output "rabbit_sg_id" {
  value = "${aws_security_group.rabbit_sg.id}"
}


output "ecs_instance_profile_name" {
  value = "${aws_iam_instance_profile.ecs_instance.name}"
}

output "ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service.arn}"
}

output "ecs_service_autoscale_role_arn" {
  value = "${aws_iam_role.ecs_service_autoscale.arn}"
}
