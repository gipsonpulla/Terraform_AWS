variable "name" {
  description = "Name prefix for network resources."
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR block."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "At least two public subnets are required for high availability."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ)."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.public_subnet_cidrs)
    error_message = "private_subnet_cidrs must contain the same number of elements as public_subnet_cidrs."
  }
}

variable "data_subnet_cidrs" {
  description = "CIDR blocks for data subnets (one per AZ)."
  type        = list(string)

  validation {
    condition     = length(var.data_subnet_cidrs) == length(var.public_subnet_cidrs)
    error_message = "data_subnet_cidrs must contain the same number of elements as public_subnet_cidrs."
  }
}

variable "enable_nat_gateway_per_az" {
  description = "When true, create one NAT gateway per AZ; otherwise create one shared NAT gateway."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
