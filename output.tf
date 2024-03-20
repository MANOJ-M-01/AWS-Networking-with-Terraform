output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.server_a.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.server_a.public_ip
}
