variable "filename" {
  default = [
    "/Users/gipsonpulla/Terraform_AWS/hcl_basics/count/myvillage2",
    "/Users/gipsonpulla/Terraform_AWS/hcl_basics/count/myvillage3",
    "/Users/gipsonpulla/Terraform_AWS/hcl_basics/count/myvillage4",
  ]
  type        = list(string)
  description = "filename input"
}

variable "permission" {
  default     = "0700"
  type        = number
  description = "file permission"
}

/* variable "filecontent" {
  default     = "welcome to uppal"
  type        = string
  description = "file content"
} */