variable "vpc_name" {
  description = "Value of the name for the VPC"
  type        = string
  default     = "main_network"
}

variable "vpc_cidr" {
  description = "Value of the CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_name" {
  description = "Value of the Public Subnet Name for the VPC"
  type        = string
  default     = "public_subnet"
}

variable "public_subnet_cidr" {
  description = "Value of the Subnet CIDR range for the VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_name" {
  description = "Value of the PrivateSubnet Name for the VPC"
  type        = string
  default     = "private_subnet"
}

variable "private_subnet_cidr" {
  description = "Value of the Subnet CIDR range for the VPC"
  type        = string
  default     = "10.0.2.0/24"
}

variable "igw_name" {
  description = "Value of the Internet Gateway for the VPC"
  type        = string
  default     = "main_network_igw"
}

variable "public_route_table_name" {
  description = "Value of the Public Route table Name for the VPC"
  type        = string
  default     = "public_rt"
}

variable "public_route_table_cidr" {
  description = "Value of the Public Route table CIDR rage for the VPC"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_route_table_name" {
  description = "Value of the Private Route table Name for the VPC"
  type        = string
  default     = "private_rt"
}

variable "private_route_table_cidr" {
  description = "Value of the Private Route table CIDR rage for the VPC"
  type        = string
  default     = "0.0.0.0/0"
}

variable "nat_name" {
  description = "Value of the Name for NAT Gateway"
  type        = string
  default     = "main_network_nat"
}

variable "public_security_group_name" {
  description = "Value of the Public Security Group Name"
  type        = string
  default     = "public_sg"
}

variable "private_security_group_name" {
  description = "Value of the Private Security Group Name"
  type        = string
  default     = "private_sg"
}

variable "ec2_ami" {
  description = "Value of the AMI id for the EC2 Instance"
  type        = string
  default     = "ami-04a81a99f5ec58529"
}

variable "ec2_type" {
  description = "Value of Instance Type for the EC2 Instance"
  type        = string
  default     = "t2.micro"
}

variable "public_ec2_name" {
  description = "Value of the Name for the Public EC2 Instance"
  type        = string
  default     = "public_instance"
}

variable "private_ec2_name" {
  description = "Value of the Name for the Private EC2 Instance"
  type        = string
  default     = "private_instance"
}

variable "ssh_key_name" {
  description = "Value of the SSH Key Pair Name for the EC2 Instance"
  type        = string
  default     = "my_public_key"
}