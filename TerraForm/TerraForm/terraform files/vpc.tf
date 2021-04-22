resource "aws_vpc" "stage" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.vpc_name}"
    }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = "${aws_vpc.stage.id}"
}

resource "aws_eip" "nat" {
    vpc = true
}



/*
  Public Subnet Zone A
*/
resource "aws_subnet" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.stage.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "eu-west-1a"

    tags {
        Name = "${var.public_subnet_name}"
    }
}

resource "aws_route_table" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.stage.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_internet_gateway.ig.id}"
    }

    tags {
        Name = "${var.public_route_table_name}"
    }
}

resource "aws_route_table_association" "eu-west-1a-public" {
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"
    route_table_id = "${aws_route_table.eu-west-1a-public.id}"
}

/*
 Nat gateway
*/

resource "aws_nat_gateway" "gw" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.eu-west-1a-public.id}"

    depends_on = ["aws_internet_gateway.ig"]
}

/*
  Private Subnet Zone B
*/
resource "aws_subnet" "eu-west-1b-private" {
    vpc_id = "${aws_vpc.stage.id}"

    cidr_block = "${var.private_subnet_zoneb_cidr}"
    availability_zone = "eu-west-1b"

    tags {
        Name = "${var.private_subnet_zoneb_name}"
    }
}

resource "aws_route_table" "eu-west-1b-private" {
    vpc_id = "${aws_vpc.stage.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "${var.private_zoneb_route_table_name}"
    }
}

resource "aws_route_table_association" "eu-west-1b-private" {
    subnet_id = "${aws_subnet.eu-west-1b-private.id}"
    route_table_id = "${aws_route_table.eu-west-1b-private.id}"
}

/*
  Private Subnet Zone C
*/
resource "aws_subnet" "eu-west-1c-private" {
    vpc_id = "${aws_vpc.stage.id}"

    cidr_block = "${var.private_subnet_zonec_cidr}"
    availability_zone = "eu-west-1c"

    tags {
        Name = "${var.private_subnet_zonec_name}"
    }
}

resource "aws_route_table" "eu-west-1c-private" {
    vpc_id = "${aws_vpc.stage.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.gw.id}"
    }

    tags {
        Name = "${var.private_zonec_route_table_name}"
    }
}

resource "aws_route_table_association" "eu-west-1c-private" {
    subnet_id = "${aws_subnet.eu-west-1c-private.id}"
    route_table_id = "${aws_route_table.eu-west-1c-private.id}"
}


