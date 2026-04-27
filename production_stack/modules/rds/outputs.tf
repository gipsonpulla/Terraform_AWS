output "db_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "Database endpoint."
}

output "db_port" {
  value       = aws_db_instance.this.port
  description = "Database port."
}

output "db_instance_identifier" {
  value       = aws_db_instance.this.identifier
  description = "RDS instance identifier."
}
