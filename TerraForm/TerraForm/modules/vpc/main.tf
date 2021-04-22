resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.vpc_name}"
    }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_eip" "nat_eip" {
    vpc = true
}



/*
  Public Subnet Zone A
*/
resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "eu-west-1a"

    tags {
        Name = "${var.public_subnet_name}"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_internet_gateway.ig.id}"
    }

    tags {
        Name = "${var.public_route_table_name}"
    }
}

resource "aws_route_table_association" "public_rta" {
    subnet_id = "${aws_subnet.public_subnet.id}"
    route_table_id = "${aws_route_table.public_rt.id}"
}

/*
 Nat gateway
*/

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.nat_eip.id}"
    subnet_id = "${aws_subnet.public_subnet.id}"

    depends_on = ["aws_internet_gateway.ig"]
}

/*
  Private Subnet Zone B
*/
resource "aws_subnet" "private_subnetB" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.private_subnetB_cidr}"
    availability_zone = "eu-west-1b"

    tags {
        Name = "${var.private_subnetB_name}"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat.id}"
    }

    tags {
        Name = "${var.private_rt_name}"
    }
}

resource "aws_route_table_association" "private_rta_subnetB" {
    subnet_id = "${aws_subnet.private_subnetB.id}"
    route_table_id = "${aws_route_table.private_rt.id}"
}

/*
  Private Subnet Zone C
*/
resource "aws_subnet" "private_subnetC" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "${var.private_subnetC_cidr}"
    availability_zone = "eu-west-1c"

    tags {
        Name = "${var.private_subnetC_name}"
    }
}


resource "aws_route_table_association" "private_rta_cubnetC" {
    subnet_id = "${aws_subnet.private_subnetC.id}"
    route_table_id = "${aws_route_table.private_rt.id}"
}

