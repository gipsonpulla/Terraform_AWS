resource "local_file" "Sunday" {
  filename = each.value
  for_each = toset(var.filename)
  source   = "/tmp/hello.txt"
}

output "days" {
  value = [for f in local_file.Sunday : f.filename]
}