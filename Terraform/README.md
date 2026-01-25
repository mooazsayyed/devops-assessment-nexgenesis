# Terraform Infrastructure for DevOps Assessment

This Terraform configuration creates an EC2 instance in AWS us-east-1 region with a properly configured security group.

## Infrastructure Components

- **EC2 Instance**: Amazon Linux 2023 with Apache web server
- **Security Group**: Allows only HTTP (80), HTTPS (443), and SSH (22) ports
- **VPC**: Uses the default VPC in us-east-1 region

## Prerequisites

1. AWS CLI installed and configured
2. Terraform installed (version >= 1.0)
3. Valid AWS credentials with EC2 permissions

## Quick Start

1. **Initialize Terraform:**
   ```bash
   cd Terraform
   terraform init
   ```

2. **Create variable file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit terraform.tfvars** (optional):
   - Add your AWS key pair name for SSH access
   - Restrict SSH access to your IP address
   - Customize instance type if needed

4. **Plan the deployment:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   ```

6. **Access your instance:**
   - Web: http://[PUBLIC_IP]
   - SSH: ssh -i your-key.pem ec2-user@[PUBLIC_IP]

## Security Configuration

The security group allows:
- **Port 80 (HTTP)**: Open to all (0.0.0.0/0)
- **Port 443 (HTTPS)**: Open to all (0.0.0.0/0)
- **Port 22 (SSH)**: Configurable (default: 0.0.0.0/0)

> **Security Note**: For production use, restrict SSH access to specific IP addresses by updating the `allowed_ssh_cidr` variable.

## Outputs

After deployment, you'll get:
- Instance ID
- Public IP address
- Public DNS name
- Security Group ID
- Web URL

## Clean Up

To destroy the infrastructure:
```bash
terraform destroy
```

## Cost Estimation

- t3.micro instance: ~$8-10/month (free tier eligible)
- Security Group: Free
- Data transfer: Varies based on usage