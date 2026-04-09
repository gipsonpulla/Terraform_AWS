provider "aws" {
    region = var.region
}

resource "aws_instance" "testserver" {
    ami = "ami-0ea87431b78a82070"
    instance_type = "t2.micro"
    tags = {
        Name = "webserver"
        description = "temp server for http"
    }
    key_name = aws_key_pair.gips_key.id
    vpc_security_group_ids = [aws_security_group.ssh-access.id]
    user_data = <<-EOF
                EOF
}

resource "aws_key_pair" "gips_key" {
    public_key = file("/tmp/hello/key.pub")
  
}

resource "aws_security_group" "ssh-access" {
    name = "ssh-access"
    description = "Allow SSH access from the Internet"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  
}