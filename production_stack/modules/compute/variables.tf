variable "name" {
  type        = string
  description = "Name prefix."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnets for ASG."
}

variable "app_security_group_id" {
  type        = string
  description = "Application security group ID."
}

variable "target_group_arns" {
  type        = list(string)
  description = "ALB target group ARNs to attach to ASG."
}

variable "ami_id" {
  type        = string
  description = "AMI ID for app instances."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type."
}

variable "min_size" {
  type        = number
  description = "ASG min size."
}

variable "max_size" {
  type        = number
  description = "ASG max size."
}

variable "desired_capacity" {
  type        = number
  description = "ASG desired size."
}

variable "app_port" {
  type        = number
  description = "Application port."
  default     = 8080
}

variable "user_data" {
  type        = string
  description = "User data script content."
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default     = {}
}
