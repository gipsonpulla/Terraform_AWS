terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}


provider "aws" {
  # Configuration options
}

resource "local_file" "animal" {
  filename        = "/Users/gipsonpulla/Terraform_AWS/hcl_basics/pets.txt"
  content         = "We love pets"
  file_permission = "0700"
}

resource "local_sensitive_file" "mysql-config" {
  filename = "/Users/gipsonpulla/Terraform_AWS/hcl_basics/myconfig.txt"
  content  = "we are mysql config"
}

resource "random_pet" "myrand" {
  prefix    = "mr."
  length    = 1
  separator = "."
}

output "pet-name" {
  value       = random_pet.myrand.id
  description = "my random pet res"

}
