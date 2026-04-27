variable "name" {
  type        = string
  description = "Name prefix."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnets for ALB."
}

variable "alb_security_group_id" {
  type        = string
  description = "ALB security group ID."
}

variable "listener_port" {
  type        = number
  description = "ALB listener port."
  default     = 80
}

variable "target_port" {
  type        = number
  description = "Target group port."
  default     = 8080
}

variable "health_check_path" {
  type        = string
  description = "Health check path."
  default     = "/health"
}

variable "deletion_protection" {
  type        = bool
  description = "Enable ALB deletion protection."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default     = {}
}
