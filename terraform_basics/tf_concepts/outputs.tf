output "public_subnets" {
  value = local.public_subnets
}

output "private_subnets" {
  value = local.private_subnets
}

output "vpc_id" {
  value       = aws_vpc.temp_vpc.id
  description = "vpcid value"

}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.temp_public : s.id]
  description = "publid subnet ids"
}

output "private_subnets_ids" {
  value       = [for s in aws_subnet.temp_private : s.id]
  description = "private subnet ids"
}

output "public_subnet_map" {
  value       = { for az, subnet in aws_subnet.temp_public : az => subnet.id }
  description = "mapf of subnet id and value"
}