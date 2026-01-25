variable "aws_region" {
  description = "AWS N.Virgina region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Name of the project for tagging"
  type        = string
  default     = "devops-assessment"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Change this to your specific IP range for security
}

variable "private_key_path" {
  description = "Relative path (from this module) to write the generated private key"
  type        = string
  default     = "terraform-ssh-key.pem"
}