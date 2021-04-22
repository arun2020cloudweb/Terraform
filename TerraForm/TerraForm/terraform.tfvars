#.......................................

## system manager variables ##
#...........................

aws_access_key = "AKIAJUSHFDJ74DADQI5A"
aws_secret_key = "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"
aws_key_path = "./key/stage.system-servcies.pem"
aws_key_name = "stage.system-servcies"
aws_region = "eu-west-1"
######
vpc_name = "stage.vpc"
vpc_cidr = "192.142.0.0/16"
public_subnet_cidr = "192.142.1.0/24"
public_subnet_name = "stg.public_subnet"
public_route_table_name = "stg.public_route_table"
private_subnet_zoneb_cidr = "192.142.2.0/24"
private_subnet_zoneb_name = "stg.private_subnet_zoneb"
private_zoneb_route_table_name = "stg.private_route_table"
private_subnet_zonec_cidr = "192.142.3.0/24"
private_subnet_zonec_name = "stg.private_subnet_zonec"
private_zonec_route_table_name = "stg.private_route_table"
db_sg = "stg.db-sg"

