data "aws_instance" "newserver" {
  instance_id = "i-093424sdfsdf32s"
}

output "newserver" {
  value = data.aws_instance.newserver.public_ip

}