variable "path_to_public_key" {
  default     = "~/keypairs/UST-apC.pub"
  description = "this is the path to my pub key"
}
variable "key_name" {
  default     = "UST-apC"
  description = "this is the public key"
}
variable "ami" {
  default = "ami-06640050dc3f556bb"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "instance_class" {
  default = "db.t2.micro"
}
variable "identifier" {
  default = "usteam2acpdb"
}
variable "db_username" {
  default = "admin"
}
variable "db_passwd" {
  default = "Admin123"
}
variable "db_name" {
  default     = "usteam2acpdb"
  description = "database name"
}
variable "VPC_cidr_block" {
  default     = "10.0.0.0/16"
  description = "custom VPC cidr block"
}
variable "VPC_tag_name" {
  default     = "USTeam2_ACP_VPC"
  description = "custom VPC tag name"
}
variable "public_subnet1_cidr_block" {
  default     = "10.0.1.0/24"
  description = "public subnet1 cidr block"
}
variable "public_subnet1_availabilityzone" {
  default     = "us-east-1a"
  description = "public subnet1 availability zone"
}
variable "public_subnet2_cidr_block" {
  default     = "10.0.3.0/24"
  description = "public subnet2 cidr block"
}
variable "public_subnet2_availabilityzone" {
  default     = "us-east-1b"
  description = "public subnet2 availability zone"
}
variable "private_subnet1_cidr_block" {
  default     = "10.0.2.0/24"
  description = "private subnet1 cidr block"
}
variable "private_subnet1_availabilityzone" {
  default     = "us-east-1a"
  description = "private subnet1 availability zone"
}
variable "private_subnet2_cidr_block" {
  default     = "10.0.4.0/24"
  description = "private subnet2 cidr block"
}
variable "private_subnet2_availabilityzone" {
  default     = "us-east-1b"
  description = "private subnet2 availability zone"
}
variable "public_routetable_cidr_block" {
  default     = "0.0.0.0/0"
  description = "public route table cidr block"
}
variable "private_routetable_cidr_block" {
  default     = "0.0.0.0/0"
  description = "private route table cidr block"
}

variable "domain_name" {
  default = "praisepeace.link"
}

variable "environment" {
  default = "dev"
}
variable "node_count" {
  default = 1
}
variable "node_type" {
  default = "cache.r6g.large"
}
# variable "availability_zones" { type = "list" }

variable "db_cache" {
  default = "true"
}

# variable "instance_type" {}
# variable "ami" {}
# variable "subnet_id" {}
# variable "availability_zone" {}
# variable "key_name" {}
# variable "vpc_security_group_ids" {}