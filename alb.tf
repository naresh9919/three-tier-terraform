module "main-alb" {
  source = "./modules/loadbalancer/"

  name = var.name
  env  = var.env
  tags = var.tags

  vpc_id          = element(module.main-vpc.vpc[*].id, 0)
  security_groups = module.lb-sg.sg[*].id
  subnets         = module.main-vpc.lb_subnets[*].id

  prod_target_ids    = module.prod-ec2.ec2_details[*].id
  uat_target_ids     = module.uat-ec2.ec2_details[*].id
  dev_target_ids     = module.dev-ec2.ec2_details[*].id
  cma_dev_target_ids = module.cma-dev-ec2.ec2_details[*].id
}
#jenkins_target_ids = module.jenkins-ec2.ec2_details[*].id
