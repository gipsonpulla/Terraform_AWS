variable "aws_region" {
  type        = string
  description = "AWS region to deploy into."
}

variable "name" {
  type        = string
  description = "Name prefix used across resources."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs."
}

variable "data_subnet_cidrs" {
  type        = list(string)
  description = "Data subnet CIDRs."
}

variable "allowed_ingress_cidrs" {
  type        = list(string)
  description = "Allowed CIDRs for ALB ingress."
}

variable "ami_id" {
  type        = string
  description = "AMI ID for application hosts."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
}

variable "asg_min_size" {
  type        = number
  description = "ASG minimum size."
}

variable "asg_max_size" {
  type        = number
  description = "ASG maximum size."
}

variable "asg_desired_capacity" {
  type        = number
  description = "ASG desired capacity."
}

variable "app_port" {
  type        = number
  description = "Application port."
  default     = 8080
}

variable "db_name" {
  type        = string
  description = "Database name."
}

variable "db_master_username" {
  type        = string
  description = "Database master username."
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class."
}

variable "db_allocated_storage" {
  type        = number
  description = "RDS allocated storage."
}

variable "db_max_allocated_storage" {
  type        = number
  description = "RDS max allocated storage."
}

variable "db_multi_az" {
  type        = bool
  description = "RDS multi-AZ setting."
}

variable "db_backup_retention_days" {
  type        = number
  description = "RDS backup retention days."
}

variable "db_final_snapshot_identifier" {
  type        = string
  description = "Final snapshot identifier if final snapshots are enabled."
  default     = null
}

variable "notification_email" {
  type        = string
  description = "Optional SNS alarm email."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
}
