#####################################################################
# This file contains the main configuration for creating a VPC in AWS using Terraform.
#######################################################################
resource "aws_vpc" "myVPC" {
  cidr_block = var.cidr
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}
######################################################################
#Internet Gateway
######################################################################
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.igw_tag
  }
}
#######################################################################
# Public Subnet
#######################################################################
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.public_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = var.public_subnet_tag_1
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.public_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available_1.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = var.public_subnet_tag_2
  }
}
######################################################################
# Database Subnet
######################################################################
resource "aws_subnet" "database_subnet_1" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.database_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available_1.names[2]
  map_public_ip_on_launch = false
  tags = {
    Name = var.database_subnet_tag_1
  } 
}
resource "aws_subnet" "database_subnet_2" { 
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.database_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available_1.names[3]
  map_public_ip_on_launch = false
  tags = {
    Name = var.database_subnet_tag_2
  } 
}   
################################################################
# Public Route Table
################################################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.public_route_table_tag
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
  }
}
##################################################################
# Database Route Table
##################################################################
resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.database_route_table_tag
  }
}
###############################################################
# Public Route Table Association
################################################################
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}
###############################################################
# Database Route Table Association
################################################################
resource "aws_route_table_association" "database_subnet_1_association" {
  subnet_id      = aws_subnet.database_subnet_1.id
  route_table_id = aws_route_table.database_rt.id
}
resource "aws_route_table_association" "database_subnet_2_association" {
  subnet_id      = aws_subnet.database_subnet_2.id
  route_table_id = aws_route_table.database_rt.id
}
############################################################################
# Security Group for Public Subnet
############################################################################
resource "aws_security_group" "public_sg" {
  name        = var.public_sg_name
  description = "Security group for public subnet"
  vpc_id      = aws_vpc.myVPC.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
    prefix_list_ids = null  
    security_groups = null
    self = null
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
  }

  tags = {
    Name = var.public_sg_tag
  }
}