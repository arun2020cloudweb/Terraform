variable "region" {
  description = "AWS region to deploy"
}

variable "aws_access_key" {
   description = ""
}

variable "aws_secret_key" {
   description = ""
}

variable "az_count" {
  description = "The number of availailbilty zones to deploy across (must be minimum of two to use ALB)"
  default = 3
}

variable "public_subnet_cidr" {
   description = "Public cidr"
}

variable "private_rt_name" {
  description = "private subnet route table"
}

variable "vpc_name" {
  description = "vpc name"
}

variable "vpc_cidr" {
  description = "CIDR vpc"
}

variable "private_subnetB_name" {
  description = "private_subnetB_name"
}

variable "private_subnetC_cidr" {
  description = "private_subnetC_cidr"
}

variable "private_subnetC_name" {
  description = "private_subnetC_name"
}

variable "private_subnetB_cidr" {
  description = "private_subnetB_cidr"
}

variable "public_subnet_name" {
  description = "public_subnet_name"
}

variable "public_route_table_name" {
  description = "public_route_table_name"
}


variable "ssh_allowed_ip" {
  description = "IP address allowed to SSH to service instance"
  default = "54.229.116.182"
}

#variable "acm_arn" {
#  description = "ARN of ACM SSL certificate"
#}

#variable "route53_zone_id" {
#  description = "Route 53 Hosted Zone ID"
#}

#variable "alb_dns_name" {
#  description = "DNS name for ALB"
#}

variable "cluster_name" {
  description = "Name of the ECS cluster"
}



variable "instance_type" {
  description = "Instance type of each EC2 instance in the ECS cluster"
}

variable "key_pair_name" {
  description = "Name of the Key Pair that can be used to SSH to each EC2 instance in the ECS cluster"
}

variable "ecs_ami" {
  description = "AMI of each EC2 instance in the ECS cluster"
  default = {
    eu-west-1 = "ami-48f9a52e"
  }
}

variable "asg_min" {
  description = "Minimum number of EC2 instances to run in the ECS cluster"
  default = 1
}

variable "asg_max" {
  description = "Maximum number of EC2 instances to run in the ECS cluster"
  default = 9
}

#variable "alb_subnet_ids" {
#  description = "Comma-separated list of subnets where ALB should be deployed"
#  default = ["${aws_subnet.private_subnetB.id}", "${aws_subnet.private_subnetC.id}", "${aws_subnet.public_subnet.id}"]
#}

