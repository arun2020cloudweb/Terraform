# The ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}"
}

#.............................
# Connector task definition
#.............................



#...........................................................................................
# The ECS task that specifies which Docker container we need to run the connector container
#..............................................................................................
resource "aws_ecs_task_definition" "system_service_task" {
  family = "system-service"
  container_definitions = "${file("${path.module}/task-definition/system-service.json")}"
}

resource "aws_ecs_task_definition" "identity_service_task" {
  family = "identity-service"
  container_definitions = "${file("${path.module}/task-definition/identity-service.json")}"
}

resource "aws_ecs_task_definition" "domain_service_task" {
  family = "domain-service"
  container_definitions = "${file("${path.module}/task-definition/domainservice.json")}"
}

resource "aws_ecs_task_definition" "businessentity_service_task" {
  family = "business-entity-service"
  container_definitions = "${file("${path.module}/task-definition/business-entity-service.json")}"
}
resource "aws_ecs_task_definition" "authentication_service_task" {
  family = "authentication-service"
  container_definitions = "${file("${path.module}/task-definition/authentication-service.json")}"
}

resource "aws_ecs_task_definition" "authentication_frontend_task" {
  family = "authentication-frontend"
  container_definitions = "${file("${path.module}/task-definition/authentication-frontend.json")}"
}

resource "aws_ecs_task_definition" "authorization_frontend_task" {
  family = "authorization-frontend"
  container_definitions = "${file("${path.module}/task-definition/authorization-frontend.json")}"
}

resource "aws_ecs_task_definition" "clientmgnt_frontend_task" {
  family = "client-management-frontend"
  container_definitions = "${file("${path.module}/task-definition/client-management-frontend.json")}"
}