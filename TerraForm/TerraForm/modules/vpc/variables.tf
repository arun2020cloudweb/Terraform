variable "region" {
  description = "AWS region to deploy "
}

variable "vpc_cidr" {
  description = "vpc_cidr"
}

variable "az_count" {
  description = "The number of availailbilty zones to deploy across (must be minimum of two to use ALB)"
}

# Use "aws ec2 describe-availability-zones --region us-east-1"
# to figure out the name of the AZs on every region as required
variable "availability_zones" {
  description = "Availability zones by region"
  default = {
    "eu-west-1" = "eu-west-1a,eu-west-1b,eu-west-1c"
  }
}

variable "public_subnet_name" {
   description = "Public subnet name"
}

variable "public_subnet_cidr" {
   description = "Public cidr"
}

variable "public_route_table_name" {
   description = "Public route table  name"

}

variable "vpc_name" {
   description = "Name of VPC"

}

variable "private_subnetB_cidr" {
   description = "CIDR range of priavte subnet B"

}

variable "private_subnetB_name" {
   description = "Private subnet B name"

}

variable "private_rt_name" {
   description = "Public route table name"

}

variable "private_subnetC_cidr" {
   description = "Private subnet C CIDR"

}


variable "private_subnetC_name" {
   description = "Name of private subnet C"

}





