resource "aws_instance" "ruby" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = var.name
  key_name      = var.key_name
  tags = {
    Name = each.value
  }
}
output "instances" {
  value = aws_instance.ruby
}

#aws ec2 create-key-pair --key-name jade 
#--query 'KeyMaterial' --output text 
#> /root/terraform-projects/project-jade/jade.pem.

#gipsonpulla:~/Terraform_AWS/hcl_basics$ aws ec2 describe-instances  | jq -r '.Reservations[].Instances[].InstanceId'
#i-0c1f5c60dfgfgdf6df8gdfg920ddfg440
#i-05sdfsdfdrfd134e5b39fe982aadertres