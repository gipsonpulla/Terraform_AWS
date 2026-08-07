terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "gipsonpulla_example212ere"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}




provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "example212ere" {
  bucket = "gipsonpulla_example212ere"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example212ere.id
  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example212ere.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_account_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example212ere.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}