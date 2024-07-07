##### VPC #####
vpc_name = "main_network"
vpc_cidr = "10.0.0.0/16"

##### PUBLIC SUBNET #####
public_subnet_cidr = "10.0.1.0/24"
public_subnet_name = "public_subnet"

##### PRIVATE SUBNET #####
private_subnet_cidr = "10.0.2.0/24"
private_subnet_name = "private_subnet"

##### INTERNET GATEWAY #####
igw_name = "main_network_igw"

##### PUBLIC ROUTE TABLE #####
public_route_table_name = "public_rt"
public_route_table_cidr = "0.0.0.0/0"

##### PRIAVE ROUTE TABLE #####
private_route_table_name = "private_rt"
private_route_table_cidr = "0.0.0.0/0"

##### NAT GATEWAY #####
nat_name = "main_network_nat"

##### SECURITY GROUP #####
public_security_group_name = "public_sg"

##### EC2 INSTANCE #####
ec2_ami          = "ami-04a81a99f5ec58529" # Latest Ubuntu AMI ID
ec2_type         = "t2.micro"
public_ec2_name  = "public_instance"
private_ec2_name = "private_instance"
ssh_key_name     = "my_public_key"