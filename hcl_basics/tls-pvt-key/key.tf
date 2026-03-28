resource "tls_private_key" "pvtkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key_details" {
  filename = "/tmp/key.txt"
  content  = tls_private_key.pvtkey.private_key_pem

}

output "key-content" {
  value       = tls_private_key.pvtkey.private_key_pem
  description = "content of the key"
  sensitive   = true
}