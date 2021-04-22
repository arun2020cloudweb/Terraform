# The ECS Cluster
resource "aws_ecs_cluster" "stage_ecs_cluster" {
  name = "${var.cluster_name}"
}

# Connectors task definition
data "template_file" "connectors_task_definition" {
  template = "${file("connectors-task-definition.json")}"

}


# The ECS task that specifies which Docker container we need to run the connectors agent container

resource "aws_ecs_task_definition" "connectors_task_definition" {
  family = "${var.connectors_task_name}"
  volume {
    name = "docker_sock"
    host_path = "/var/run/docker.sock"
  }
  volume {
    name = "proc"
    host_path = "/proc/"
  }
  volume {
    name = "cgroup"
    host_path = "/cgroup/"
  }
  container_definitions = "${data.template_file.connectors_task_definition.rendered}"
}

