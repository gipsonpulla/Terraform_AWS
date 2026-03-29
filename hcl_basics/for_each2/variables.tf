variable "users" {
  type    = list(string)
  default = ["/tmp/user10", "/tmp/user11", "/tmp/user12", "/tmp/user10"]
}

variable "content" {
  default = "password: S3cr3tP@ssw0rd"

}


