"""
The terraform apply command may have failed, even though terraform validate completed successfully.
This is expected behavior.
The terraform validate command performs only a basic syntax and argument check. It does not verify whether the values you have provided are appropriate or sufficient for the actual resource to be created. 
In contrast, terraform apply interacts with the provider to provision the resource and can fail if any required values are missing or incorrect at runtime.
"""

resource "local_file" "key_data" {
  filename        = "/tmp/.pki/private_key.pem"
  content         = tls_private_key.private_key.private_key_pem
  file_permission = "0400"
}
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = "4085"
}
resource "tls_cert_request" "csr" {
  private_key_pem = tls_private_key.private_key.private_key_pem
  depends_on      = [local_file.key_data]

  subject {
    common_name  = "flexit.com"
    organization = "FlexIT Consulting Services"
  }
}

