output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID."
}

output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "Public subnet IDs."
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
  description = "Private subnet IDs."
}

output "data_subnet_ids" {
  value       = values(aws_subnet.data)[*].id
  description = "Data subnet IDs."
}
