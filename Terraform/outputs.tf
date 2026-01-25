output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.web_sg.arn
}

output "web_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "key_pair_name" {
  description = "Name of the SSH key pair used by the instance"
  value       = aws_key_pair.ssh.key_name
}

output "private_key_path" {
  description = "Path to the generated private key file"
  value       = local_file.ssh_private_key.filename
}