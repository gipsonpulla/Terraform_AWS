variable "file_content_bool" {
  type        = bool
  default     = false
  description = "file content boolean"

}
variable "ami-image" {
  default     = "ami-imadsaff"
  type        = string
  description = "ami image description"
}

variable "number_example" {
  description = "An example of a number variable in Terraform"
  type        = number
  default     = 42
}

variable "list_example" {
  description = "An example of a list in Terraform"
  type        = list(any)
  default     = ["a", "b", "c"]
}

variable "list_numeric_example" {
  description = "An example of a numeric list in Terraform"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "map_example" {
  description = "An example of a map in Terraform"
  type        = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

variable "object_example" {
  description = "An example of a structural type in Terraform"
  type = object({
    name    = string
    age     = number
    tags    = list(string)
    enabled = bool
  })
  default = {
    name    = "value1"
    age     = 42
    tags    = ["a", "b", "c"]
    enabled = true
  }
}

variable "file-tuple" {
  type    = tuple([string, number, string])
  default = ["us-east-1a", 1, "us-east-1b"]

}

variable "file-content-obj" {
  type = object({
    name    = string
    age     = number
    tags    = list(string)
    enabled = bool
  })
  default = {
    name    = "gipson"
    age     = "39"
    tags    = ["swe", "husband"]
    enabled = true
  }
}

variable "file_name" {
  type        = string
  default     = "files/gipson_file.txt"
  description = "The sample file name"
  validation {
    condition     = length(var.file_name) > 5
    error_message = "The file name must be more that 55 characters"
  }
  sensitive = true
  nullable  = false
}