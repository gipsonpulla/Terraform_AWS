Variable defintion precedence

1) Env vars
2) terraform.tfvar (if present)
3) terraform.tfvar.json (if present)
4) Any *auto.tfvars.tf (if present)
5) -var or -var-file option in the cmd line
