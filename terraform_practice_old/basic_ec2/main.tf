data "aws_vpc" "selected" {
  default = true
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "instance" {
  name   = "terraform-example-instance"
  vpc_id = data.aws_vpc.selected.id
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = "172.31.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_instance" "example" {
  ami                    = "ami-0157af9aea2eef346"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "my-web"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
  EOF
}
