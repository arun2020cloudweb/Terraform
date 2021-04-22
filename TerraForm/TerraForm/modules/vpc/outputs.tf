output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "subnet_private_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id, aws_subnet.private_subnetC.*.id)}"
}

output "subnet_public_ids" {
  value = "${join(",", aws_subnet.public_subnet.*.id)}"
}


output "subnet_privateB_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id)}"
}


output "subnet_privateC_ids" {
  value = "${join(",", aws_subnet.private_subnetC.*.id)}"
}

output "subnet_alb_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id, aws_subnet.private_subnetC.*.id, aws_subnet.public_subnet.*.id)}"
}

output "subnet_elb_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id, aws_subnet.private_subnetC.*.id)}"
}

output "subnet_rabbit_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id)}"
}

output "subnet_db_ids" {
  value = "${join(",", aws_subnet.private_subnetB.*.id, aws_subnet.private_subnetC.*.id, aws_subnet.public_subnet.*.id)}"
}


