output "vpc_dev_id" {
  value = module.vpc_dev.vpc_id
}
output "vpc_prod_id" {
  value = module.vpc_prod.vpc_id
}
output "s3_dev_bucket" {
  value = module.s3_dev.bucket_name
}
output "s3_prod_bucket" {
  value = module.s3_prod.bucket_name
}