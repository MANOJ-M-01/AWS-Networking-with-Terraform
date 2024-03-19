# Provider Block
provider "aws" {
  profile = "manoj_admin"
  region  = "us-east-1"
}

# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Public Subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.my_test_vpc.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = var.subnet_name
  }
}

# Private Subnet
resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.my_test_vpc.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = var.subnet_name
  }
}

# Create a route to the internet
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my_test_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Create a route to the NAT GateWay
resource "aws_nat_gateway" "IGW" {
  subnet_id = PrivateSubnet.id
  tags = {
    Name = var.igw_name
  }
}

# Create new route table with IGW
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }

  tags = {
    Name = var.igw_name
  }
}

# Create new route table with IGW
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.IGW.id
  }

  tags = {
    Name = var.nat_name
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "public_1_rt_assoc" {
  subnet_id      = aws_subnet.my_test_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Creates new security group open to HTTP traffic
resource "aws_security_group" "app_sg" {
  name   = "HTTP"
  vpc_id = aws_vpc.my_test_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance in Public network
resource "aws_instance" "server_a" {
  ami           = var.ec2_ami
  instance_type = "t2.micro"

  subnet_id                   = aws_subnet.PublicSubnet.id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex
  
  amazon-linux-extras install nginx1 -y
  echo "<h1>This is a new server</h1>" > /usr/share/nginx/html/index.html
  systemctl enable nginx
  systemctl start nginx
  EOF

  tags = {
    "Name" : var.ec2_name
  }
}

# Create EC2 Instance in Private network
resource "aws_instance" "server_b" {
  ami           = var.ec2_ami
  instance_type = "t2.micro"

  subnet_id                   = aws_subnet.PrivateSubnet.id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = false


  tags = {
    "Name" : var.ec2_name
  }
}
