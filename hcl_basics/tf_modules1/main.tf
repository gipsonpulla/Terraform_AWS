module "pay_roll" {
  source     = "./modules/payroll_app"
  ami        = "i-sdfdsfxsrqas"
  app_region = "us-east-1"
}
