resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "example" {
  count  = 5
  bucket = "example-${count.index}-${random_string.suffix.result}"
  tags = {
    Name = "example-${count.index}"
    Env  = "dev"
  }
}