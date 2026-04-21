terraform {
  backend "s3" {
    bucket       = "gips-tf-backend-state0912092321"
    key          = "terraform.tfstate"
    use_lockfile = true
    region       = "us-east-1"

  }
}
resource "local_file" "fruits" {
  filename        = "/tmp/fruits_list.txt"
  content         = "I love banana"
  file_permission = "0700"

}