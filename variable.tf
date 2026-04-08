variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "tcw_vpc"
}
variable "dns_support" {
  description = "Enable or disable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "dns_hostnames" {
  description = "Enable or disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "igw_tag" {
  description = "The name tag for the Internet Gateway"
  type        = string
  default     = "tcw_igw"
}
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}
variable "public_subnet_cidr_1" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "192.168.1.0/24"
}
variable "public_subnet_cidr_2" {
  description = "The CIDR block for the second public subnet"
  type        = string
  default     = "192.168.2.0/24"
}
variable "public_subnet_tag_1" {
  description = "The name tag for the first public subnet"
  type        = string
  default     = "tcw_public_subnet_1"
}
variable "public_subnet_tag_2" {
  description = "The name tag for the second public subnet"
  type        = string
  default     = "tcw_public_subnet_2"
}

variable "public_sg_tag" {
  description = "The name tag for the public security group"
  type        = string
  default     = "tcw_public_sg"
}
variable "map_public_ip_on_launch" {
  description = "Whether to assign a public IP address to instances launched in the public subnet"
  type        = bool
  default     = true
}
variable "database_subnet_cidr_1" {
  description = "The CIDR block for the database subnet"
  type        = string
  default     = "192.168.5.0/24"
}
variable "database_subnet_cidr_2" {
  description = "The CIDR block for the second database subnet"
  type        = string
  default     = "192.168.6.0/24"    
}
variable "public_route_table_tag" {
  description = "The name tag for the public route table"
  type        = string
  default     = "tcw_public_route_table"
}
variable "database_subnet_tag_1" {
  description = "The name tag for the first database subnet"
  type        = string
  default     = "tcw_database_subnet_1"
}
variable "database_subnet_tag_2" {
  description = "The name tag for the second database subnet"
  type        = string
  default     = "tcw_database_subnet_2"
}
variable "database_route_table_tag" {
  description = "The name tag for the database route table"
  type        = string
  default     = "tcw_database_route_table"
}
variable "public_sg_name" {
  description = "The name of the security group for the public subnet"
  type        = string
  default     = "tcw_public_sg"
}