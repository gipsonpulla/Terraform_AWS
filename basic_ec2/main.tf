provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0157af9aea2eef346"
  instance_type = "t2.micro"
  subnet_id = "subnet-0484ed14577ad95f8"
  tags = {
    Name = "my-web"
  }
}
