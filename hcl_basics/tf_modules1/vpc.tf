module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "vasya.pupkin"

  force_destroy           = true
  pgp_key                 = "keybase:test"
  password_reset_required = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
