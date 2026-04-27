variable "name" {
  type        = string
  description = "Name prefix."
}

variable "asg_name" {
  type        = string
  description = "Auto Scaling Group name."
}

variable "alb_arn_suffix" {
  type        = string
  description = "ALB ARN suffix."
}

variable "target_group_arn_suffix" {
  type        = string
  description = "Target group ARN suffix."
}

variable "notification_email" {
  type        = string
  description = "Optional email subscription for SNS alarms."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default     = {}
}
