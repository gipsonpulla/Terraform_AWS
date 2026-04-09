provider "aws" {
  region = "us-east-1"
}
# 🔹 AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3"
}
# 🔹 VPC DEV
module "vpc_dev" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "vpc-dev"
}
# 🔹 VPC PROD
module "vpc_prod" {
  source     = "./modules/vpc"
  cidr_block = "10.1.0.0/16"
  name       = "vpc-prod"
}
# 🔹 S3 DEV
module "s3_dev" {
  source      = "./modules/s3"
  bucket_name = "my-dev-bucket-gips23-2026"
}
# 🔹 S3 PROD
module "s3_prod" {
  source      = "./modules/s3"
  bucket_name = "my-prod-bucket-gips22-2026"
}