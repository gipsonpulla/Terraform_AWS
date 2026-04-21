resource "local_file" "myvillage" {
  filename        = var.filename[count.index]
  file_permission = var.permission
  #  content         = var.filecontent
  source = "/etc/os-release"
  count  = length(var.filename)
}

output "myroots" {
  value = local_file.myvillage
}