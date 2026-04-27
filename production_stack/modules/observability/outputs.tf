output "alarm_topic_arn" {
  value       = aws_sns_topic.alarms.arn
  description = "SNS topic ARN used for alarm notifications."
}
