resource "local_sensitive_file" "myvillage" {
  for_each = toset(var.users)
  filename = each.value
  content  = var.content
}
