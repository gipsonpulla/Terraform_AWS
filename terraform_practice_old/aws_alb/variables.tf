variable "vpc_az" {
  type        = list(string)
  description = "az names list"
  default     = ["us-east-1a", "us-east-1b"]
}