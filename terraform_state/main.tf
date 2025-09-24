resource "aws_s3_bucket" "my-state" {
  bucket = "mygipson-state"
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }
}

# Enable versioning so you can see the full revision history of your
# state files
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.my-state.id
  versioning_configuration {
    status = "Enabled"
  }

}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.my-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#creating a dynamodb table for locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform_locks_for_state_file"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


