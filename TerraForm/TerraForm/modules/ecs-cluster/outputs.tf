output "cluster_name" {
  value = "${aws_ecs_cluster.ecs_cluster.name}"
}


output "authentication_frontend_task" {
  value = "${aws_ecs_task_definition.authentication_frontend_task.family}"
}

output "authorization_frontend_task" {
  value = "${aws_ecs_task_definition.authorization_frontend_task.family}"
}

output "clientmgnt_frontend_task" {
  value = "${aws_ecs_task_definition.clientmgnt_frontend_task.family}"
}

output "authentication_service_task" {
  value = "${aws_ecs_task_definition.authentication_service_task.family}"
}

output "businessentity_service_task" {
  value = "${aws_ecs_task_definition.businessentity_service_task.family}"
}

output "domain_service_task" {
  value = "${aws_ecs_task_definition.domain_service_task.family}"
}

output "identity_service_task" {
  value = "${aws_ecs_task_definition.identity_service_task.family}"
}

output "system_service_task" {
  value = "${aws_ecs_task_definition.system_service_task.family}"
}