output "public_ip" {
  value       = aws_instance.my-web.public_ip
  description = "public ip of the ec2 instance"

}