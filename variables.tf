variable "vpc_cidr" {
  description = "Value of the CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Value of the name for the VPC"
  type        = string
  default     = "MyTestVPC"
}

variable "public_subnet_name" {
  description = "Value of the Public Subnet Name for the VPC"
  type        = string
  default     = "PublicSubnet"
}

variable "private_subnet_name" {
  description = "Value of the PrivateSubnet Name for the VPC"
  type        = string
  default     = "PrivateSubnet"
}

variable "public_subnet_cidr" {
  description = "Value of the Subnet CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  description = "Value of the Subnet CIDR range for the VPC"
  type        = string
  default     = "10.0.1.0/24"
}

variable "igw_name" {
  description = "Value of the Internet Gateway for the VPC"
  type        = string
  default     = "MyTestIGW"
}

variable "nat_name" {
  description = "Value of the Name for NAT Gateway"
  type        = string
  default     = "my-nat"
}

variable "ec2_ami" {
  description = "Value of the AMI id for the EC2 Instance"
  type        = string
  default     = "ami-0d7a109bf30624c99"
}

variable "server_a_ec2_name" {
  description = "Value of the Name for the EC2 Instance"
  type        = string
  default     = "PublicEC2"
}

variable "server_b_ec2_name" {
  description = "Value of the Name for the EC2 Instance"
  type        = string
  default     = "PrivateEC2"
}
