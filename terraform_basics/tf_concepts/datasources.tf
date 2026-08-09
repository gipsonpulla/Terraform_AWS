data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets = [
    for k, az in local.azs :
    cidrsubnet(var.vpc_cidr, var.subnet_newbits, k)
  ]
  private_subnets = [
    for k, az in local.azs :
    cidrsubnet(var.vpc_cidr, var.subnet_newbits, k + 10)
  ]
}