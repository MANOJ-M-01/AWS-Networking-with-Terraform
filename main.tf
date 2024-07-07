provider "aws" {
  profile = "manoj_admin"
  region  = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main_network" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_network"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_network.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main_network.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_network.id
  tags = {
    Name = "main_network_igw"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_network.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt"
  }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Create Route Table for Private Subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_network.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "private_rt"
  }
}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "main_network_nat"
  }
}


# Create Public http and https Security Group
resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.main_network.id
  name        = "public_sg"
  description = "Allow HTTP and HTTPS outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}

# Create Security Group for Private Instance
resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.main_network.id
  name        = "private_sg"
  description = "Allow SSH from public subnet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }

  tags = {
    Name = "private_sg"
  }
}

# # Create Key Pair
# resource "aws_key_pair" "mypublickey" {
#   key_name   = "mypublickey"
#   public_key = file("~/.ssh/id_rsa.pub")  # Change this to your public key file path
# }

# Create Public EC2 Instance
resource "aws_instance" "public_instance" {
  ami                         = "ami-04a81a99f5ec58529" # Latest Ubuntu AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = "my_public_key"
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nginx
              sudo systemctl restart nginx
              EOF

  tags = {
    Name = "public_instance"
  }
}

# Create Private EC2 Instance
resource "aws_instance" "private_instance" {
  ami                    = "ami-04a81a99f5ec58529" # Latest Ubuntu AMI ID
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  # key_name        = aws_key_pair.mypublickey.key_name
  associate_public_ip_address = false

  tags = {
    Name = "private_instance"
  }
}