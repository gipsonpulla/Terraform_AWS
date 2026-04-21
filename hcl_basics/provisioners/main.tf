resource "aws_instance" "primary-server" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  key_name      = "gips_k8s"

  provisioner "local-exec" {
    command = "echo ${aws_instance.primary-server.public_ip} > /tmp/pub_ip.txt"
  }
}