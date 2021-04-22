variable "security_group_db_sg" {
  description = "Id of security group allowing internal traffic"
}

variable "db_subnet_ids" {
  description = "Comma-separated list of subnets where ALB should be deployed"
}

variable "identifier" {
  default     = "stage-rds"
  description = "Identifier for your DB"
}

variable "storage" {
  default     = "20"
  description = "Storage size in GB"
}

variable "engine" {
  default     = "postgres"
  description = "Engine type, example values mysql, postgres"
}

variable "engine_version" {
  description = "Engine version"

  default = {
    postgres = "9.5.4"
  }
}

variable "instance_class" {
  default     = "db.t2.small"
  description = "Instance class"
}

variable "db_name" {
  default     = "stg_systemservices"
  description = "db name"
}

variable "username" {
  default     = "stg_systemservices"
  description = "User name"
}

variable "password" {
  default = "L0gi9systemservices"
  description = "password shoud be secure and should not be visible"

}