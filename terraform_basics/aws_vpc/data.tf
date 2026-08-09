data "aws_availability_zones" "example" {
  all_availability_zones = true
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  azs = data.aws_availability_zones.example.names
  public_subnet = 
}

