/* If you observe the output of the previous terraform apply, 
you will see that using the create_before_destroy lifecycle 
rule with the local_file resource caused Terraform to attempt 
to create the new file first. 
However, since the filename argument was the same, 
Terraform immediately deleted the existing file before the new one 
could be created during the recreation process.
This illustrates why using create_before_destroy with local_file 
resources is not always advisable, 
as the file path must be unique for simultaneous creation.
On the other hand, the random_string resource is only recorded in 
Terraform state and does not have this limitation.
If you run terraform apply again, the local_file resource will be 
created because it does not exist currently.
 */

resource "local_file" "file" {
  filename        = var.filename
  file_permission = var.permission
  content         = "This is a random string - ${random_string.string.id}"

}

resource "random_string" "string" {
  length = var.length
  keepers = {
    length = var.length
  }
  lifecycle {
    create_before_destroy = true
  }

}


