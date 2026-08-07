resource "random_string" "randstr" {
    length = 6
    upper = false
    lower = false
}

resource "aws_s3_bucket" "temp_bucket" {
    bucket = "tfstate-gips-pulla-${var.env_name}-${random_string.randstr.result}"
    lifecycle {
      prevent_destroy = false
    }
    tags = {
        Name = "tfstate-${var.env_name}-${var.aws_region}"
        Environment = var.env_name
        Project = "remote-backend"
        Purpose = "temporary"
    }
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.temp_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
  bucket = aws_s3_bucket.temp_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}