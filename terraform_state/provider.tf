terraform {
    backend "s3" {
    bucket         = "mygipson-state"
    key            = "s3/terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform_locks_for_state_file"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}