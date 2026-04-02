provider "aws" {
    region = "us-east-1"
  
}

resource "aws_s3_bucket" "bucket1" {
    bucket = "opppalhome123098123098"
    tags = {
        Description = "temporary bucket for s3"
    }
}

resource "aws_s3_object" "bucket1" {
    bucket = aws_s3_bucket.bucket1.id
    content = "/tmp/hello.txt"
    key = "hello.txt"
}

data "aws_s3_bucket_policy" "finance-policy" {
    #group_name = "finance-developers"
}

resource "aws_s3_bucket_policy" "bucket1-policy" {
    bucket = aws_s3_bucket.bucket1.id
    policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "*",
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::&{aws_s3_bucket.bucket1.id}/*",
        "Principal": {
            "AWS": [
                "${data.aws_s3_bucket_policy.finance-policy.arn}
            ]
        }
        }
    ]
    }
    EOF
}