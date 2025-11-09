provider "aws" {
  region = "us-east-1"
}

resource "local_file" "file-ex-string" {
  filename = "files/file-string.txt"
  content  = "demo var filename"
}

resource "local_file" "file-ex-map" {
  filename = "files/file-map.txt"
  content  = var.map_example["key1"]
}

resource "local_file" "file-ex-tuple" {
  filename = "files/file-tup.txt"
  content  = var.file-tuple[1]
}

resource "local_file" "file-ex-obj" {
  filename = "files/file-obj.txt"
  content  = var.file-content-obj.tags[1]
}

resource "local_file" "file_name_con" {
    filename = "files/gipson_file_con.txt"
    content = "Demo file content"
}