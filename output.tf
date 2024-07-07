output "vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.main_network.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "public_instance_id" {
  description = "ID of the public instance"
  value       = aws_instance.public_instance.id
}

output "private_instance_id" {
  description = "ID of the private instance"
  value       = aws_instance.private_instance.id
}

output "public_instance_public_ip" {
  description = "Public IP address of the public instance"
  value       = aws_instance.public_instance.public_ip
}
