terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "first" {
  ami           = var.ec2-ami-id
  instance_type = "t2.micro"

  tags = {
    Name = "first-host"
  }

}

resource "local_file" "demo" {
  filename = "tfdemo.tx"
  content = "demo file"
}