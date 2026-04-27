output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "ALB security group ID."
}

output "app_security_group_id" {
  value       = aws_security_group.app.id
  description = "App security group ID."
}

output "db_security_group_id" {
  value       = aws_security_group.db.id
  description = "DB security group ID."
}
