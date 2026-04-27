variable "name" {
  type        = string
  description = "Name prefix."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID."
}

variable "allowed_ingress_cidrs" {
  type        = list(string)
  description = "Allowed CIDRs to reach ALB listener ports."
  default     = ["0.0.0.0/0"]
}

variable "alb_port" {
  type        = number
  description = "ALB listener port."
  default     = 80
}

variable "app_port" {
  type        = number
  description = "Application port on compute instances."
  default     = 8080
}

variable "db_port" {
  type        = number
  description = "Database port."
  default     = 5432
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default     = {}
}
