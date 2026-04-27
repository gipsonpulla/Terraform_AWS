output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "Public DNS of application load balancer."
}

output "db_endpoint" {
  value       = module.rds.db_endpoint
  description = "RDS endpoint."
}

output "alarm_topic_arn" {
  value       = module.observability.alarm_topic_arn
  description = "SNS topic used for alarms."
}
