# Terraform Infrastructure Baseline

This repository provides a production-oriented, modular Terraform stack for AWS with:

- Multi-AZ networking (`public`, `private`, `data` subnets)
- Secure security group segmentation (`alb`, `app`, `db`)
- Internet-facing ALB with health-checked target group
- EC2 Auto Scaling Group in private subnets
- PostgreSQL RDS in data subnets with encryption and backups
- CloudWatch alarms + SNS notifications
- Separate `dev` and `prod` environments

## Architecture

- `modules/network`: VPC, subnets, routing, NAT gateways
- `modules/security`: Security groups and trusted traffic boundaries
- `modules/alb`: ALB, target group, listener
- `modules/compute`: IAM role/profile, launch template, ASG
- `modules/rds`: Subnet group and PostgreSQL RDS instance
- `modules/observability`: SNS topic and key CloudWatch alarms
- `environments/dev`: Lower-cost defaults for development
- `environments/prod`: High-availability defaults for production

## Prerequisites

- Terraform `>= 1.6.0`
- AWS credentials configured for your target account
- A selected AWS region

## Quick Start

1. Copy backend template and update values:

```bash
cp environments/dev/backend.hcl.example environments/dev/backend.hcl
cp environments/prod/backend.hcl.example environments/prod/backend.hcl
```

2. Initialize and apply `dev`:

```bash
cd environments/dev
terraform init -backend-config=backend.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

3. Initialize and apply `prod`:

```bash
cd ../prod
terraform init -backend-config=backend.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

## State Management Recommendation

Use remote state with S3 + DynamoDB locking. The backend templates in each environment include required keys.

## Notes

- The default AMI IDs in `terraform.tfvars` are placeholders. Replace with region-appropriate AMIs.
- `prod` defaults are set for higher durability (e.g., multi-AZ DB, stronger retention).
- Tighten CIDR allow-lists and rotate secrets according to your security policy.
