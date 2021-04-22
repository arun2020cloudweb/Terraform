# Configure the AWS Provider
provider "aws" {
  
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

module "vpc" {
  source = "./modules/vpc"

  region = "${var.region}"
  az_count = "${var.az_count}"
  vpc_name = "${var.vpc_name}"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet_name = "${var.public_subnet_name}"
  public_subnet_cidr = "${var.public_subnet_cidr}"
  public_route_table_name = "${var.public_route_table_name}"
  private_subnetB_cidr = "${var.private_subnetB_cidr}"
  private_subnetB_name = "${var.private_subnetB_name}"
  private_rt_name = "${var.private_rt_name}"
  private_subnetC_cidr = "${var.private_subnetC_cidr}"
  private_subnetC_name = "${var.private_subnetC_name}"
}

module "security" {
  source = "./modules/security"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_cidr_block = "${module.vpc.vpc_cidr_block}"
  ssh_allowed_ip = "${var.ssh_allowed_ip}"
}

module "rabbit" {
  source = "./modules/rabbit"

  instance_type = "${var.instance_type}"
  key_pair_name = "${var.key_pair_name}"
  security_group_rabbit_id = "${module.security.rabbit_sg_id}"
  rabbit_subnet_ids = "${module.vpc.subnet_rabbit_ids}"
  elb_rabbit_id = "${module.elb.elb_id}"
}

module "alb" {
  source = "./modules/alb"

  security_group_internal_id = "${module.security.internal_id}"
  security_group_inbound_id = "${module.security.inbound_id}"
  alb_subnet_ids = "${module.vpc.subnet_alb_ids}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "elb" {
  source = "./modules/elb-rabbit"
  security_group_rabbit_id = "${module.security.rabbit_sg_id}"
  elb_subnet_ids = "${module.vpc.subnet_elb_ids}"
}

module "db" {
  source = "./modules/db"

  security_group_db_sg = "${module.security.db_sg_id}"
  db_subnet_ids = "${module.vpc.subnet_db_ids}"
}

module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  cluster_name = "${var.cluster_name}"
}

module "ecs_instances" {
  source = "./modules/ecs-instances"

  cluster_name = "${module.ecs_cluster.cluster_name}"
  instance_type = "${var.instance_type}"
  key_pair_name = "${var.key_pair_name}"
  instance_profile_name = "${module.security.ecs_instance_profile_name}"
  security_group_ecs_instance_id = "${module.security.internal_id}"
#  image_id = "${lookup(var.ecs_ami, var.region)}"
  asg_min = "${var.asg_min}"
  asg_max = "${var.asg_max}"
  ecs_cluster_subnet_ids = "${module.vpc.subnet_private_ids}"
  target_group_arn = "${module.alb.target_group_arn}"
}

