module "network" {
  source = "../../modules/network"

  name                      = var.name
  cidr_block                = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_subnet_cidrs      = var.private_subnet_cidrs
  data_subnet_cidrs         = var.data_subnet_cidrs
  enable_nat_gateway_per_az = true
  tags                      = var.tags
}

module "security" {
  source = "../../modules/security"

  name                  = var.name
  vpc_id                = module.network.vpc_id
  allowed_ingress_cidrs = var.allowed_ingress_cidrs
  app_port              = var.app_port
  tags                  = var.tags
}

module "alb" {
  source = "../../modules/alb"

  name                  = var.name
  vpc_id                = module.network.vpc_id
  public_subnet_ids     = module.network.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  target_port           = var.app_port
  deletion_protection   = true
  tags                  = var.tags
}

module "compute" {
  source = "../../modules/compute"

  name                  = var.name
  private_subnet_ids    = module.network.private_subnet_ids
  app_security_group_id = module.security.app_security_group_id
  target_group_arns     = [module.alb.target_group_arn]

  ami_id           = var.ami_id
  instance_type    = var.instance_type
  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity
  app_port         = var.app_port

  user_data = <<-EOT
    #!/bin/bash
    set -euxo pipefail
    yum update -y
    yum install -y python3
    cat <<'HTML' >/tmp/index.html
    <html><body><h1>Service healthy</h1></body></html>
    HTML
    nohup python3 -m http.server ${var.app_port} --directory /tmp >/var/log/app.log 2>&1 &
  EOT

  tags = var.tags
}

module "rds" {
  source = "../../modules/rds"

  name                      = var.name
  db_name                   = var.db_name
  master_username           = var.db_master_username
  instance_class            = var.db_instance_class
  allocated_storage         = var.db_allocated_storage
  max_allocated_storage     = var.db_max_allocated_storage
  multi_az                  = var.db_multi_az
  backup_retention_period   = var.db_backup_retention_days
  db_subnet_ids             = module.network.data_subnet_ids
  db_security_group_id      = module.security.db_security_group_id
  deletion_protection       = true
  skip_final_snapshot       = false
  final_snapshot_identifier = var.db_final_snapshot_identifier
  tags                      = var.tags
}

module "observability" {
  source = "../../modules/observability"

  name                    = var.name
  asg_name                = module.compute.autoscaling_group_name
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
  notification_email      = var.notification_email
  tags                    = var.tags
}
