terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "aws" {
  region = "us-east-1"

}
resource "aws_iam_user" "AdminUser" {
  name = "mufti"
  tags = {
    description = "Tech lead iam"
  }
}

resource "local_file" "file1" {
  filename = "/tmp/local.txt"
  content  = "hello gips tf"
}

resource "aws_iam_policy" "admin_policy" {
  name   = "Adminusers"
  policy = file("admin-policy.json")
}

resource "aws_iam_user_policy_attachment" "policy_attach" {
  user       = aws_iam_user.AdminUser.name
  policy_arn = aws_iam_policy.admin_policy.arn
}