output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "ALB DNS name."
}

output "alb_arn_suffix" {
  value       = aws_lb.this.arn_suffix
  description = "ALB ARN suffix for metrics dimensions."
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "Target group ARN."
}

output "target_group_arn_suffix" {
  value       = aws_lb_target_group.this.arn_suffix
  description = "Target group ARN suffix for metrics dimensions."
}
