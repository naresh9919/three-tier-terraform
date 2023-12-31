module "main-vpc" {
  source = "./modules/vpc/"

  name = var.name
  env  = var.env
  cidr = var.vpc_cidr

  azs = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]

  app_subnets     = var.prod_subnets
  uat_subnets     = var.uat_subnets
  dev_subnets     = var.dev_subnets
  jenkins_subnets = var.jenkins_subnets
  public_subnets  = var.mgt_subnets
  lb_subnets      = var.lb_subnets
  rds_subnets     = var.rds_subnets

  enable_nat_gateway     = true
  one_nat_gateway_per_az = false
  single_nat_gateway     = true

  create_rds_subnet_group = true

  tags = var.tags

  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC endpoint for S3
  enable_s3_endpoint = false
}
