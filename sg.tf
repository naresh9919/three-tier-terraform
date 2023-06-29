module "mgt-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "prod"
  sg_suffix = "mgt"
  desc_info = "Security Group for Management Ec2s"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH connections from internet"
    },
  ]
}

module "lb-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "prod"
  desc_info = "Security Group for Loadbalancer Ec2s"
  sg_suffix = "lb"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP connections from internet"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS connections from internet"
    },
  ]
}


module "prod-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "prod"
  desc_info = "Security Group for Prod Ec2s"
  sg_suffix = "app"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH connections from Management Resources"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP connections from Load Balancer"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS connections from Load Balancer"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 9323
      to_port     = 9323
      protocol    = "tcp"
      description = "Allow 9323 docker container monitoring matrix"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 8082
      to_port     = 8082
      protocol    = "tcp"
      description = "Allow 8082 docker container monitoring grafana"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.bpd_prod_subnets)
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      description = "Allow port for elk monitoring"
    },

  ]
}

module "uat-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "uat"
  desc_info = "Security Group for UAT Ec2s"
  sg_suffix = "app"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH connections from Management Resources"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP connections from Load Balancer"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS connections from Load Balancer"
    },
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Allow postgres port connections from Management Resources"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 9323
      to_port     = 9323
      protocol    = "tcp"
      description = "Allow 9323 docker container monitoring matrix"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 8082
      to_port     = 8082
      protocol    = "tcp"
      description = "Allow 8082 docker container monitoring grafana"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.bpd_prod_subnets)
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      description = "Allow port for elk monitoring"
    },
  ]
}

module "dev-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "dev"
  desc_info = "Security Group for Dev Ec2s"
  sg_suffix = "app"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH connections from Management Resources"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP connections from Load Balancer"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS connections from Load Balancer"
    },
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Allow postgres port connections from Management Resources"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 9323
      to_port     = 9323
      protocol    = "tcp"
      description = "Allow 9323 docker container monitoring matrix"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 8082
      to_port     = 8082
      protocol    = "tcp"
      description = "Allow 8082 docker container monitoring grafana"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.bpd_prod_subnets)
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      description = "Allow port for elk monitoring"
    },

  ]
}

module "jenkins-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "prod"
  desc_info = "Security Group for Jenkins Ec2s"
  sg_suffix = "jenkins"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = var.mgt_subnets
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH connections from Management Resources"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP connections from Load Balancer"
    },
  ]
}

module "rds-prod-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "prod"
  desc_info = "Security Group for Jenkins Ec2s"
  sg_suffix = "rds"
  tags_sg   = var.tags

  create_sg = true

  # create_sg_rule = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = var.prod_database_port
      to_port     = var.prod_database_port
      protocol    = "tcp"
      description = "Allow db connections from Prod Application Resources"
    },
  ]
}


module "rds-uat-dev-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "uat-dev"
  desc_info = "Security Group for Jenkins Ec2s"
  sg_suffix = "rds"
  tags_sg   = var.tags

  create_sg = true

  # create_sg_rule = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = var.uat_dev_database_port
      to_port     = var.uat_dev_database_port
      protocol    = "tcp"
      description = "Allow db connections from UAT and Dev Resources"
    },
  ]
}

# CMA dev SG
module "cma-dev-sg" {
  source = "./modules/security_group/"

  name      = var.name
  env       = "dev"
  desc_info = "Security Group for CMA Dev Ec2s"
  sg_suffix = "cma-dev-app"
  tags_sg   = var.tags

  create_sg = true

  vpc-id = element(module.main-vpc.vpc[*].id, 0)

  ingress_rules = [
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH connections from Management Resources"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP connections from Load Balancer"
    },
    {
      cidr_blocks = var.lb_subnets
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow HTTPS connections from Load Balance"
    },
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Allow MYSQL port connections from Management Resources"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 9323
      to_port     = 9323
      protocol    = "tcp"
      description = "Allow 9323 docker container monitoring matrix"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 8082
      to_port     = 8082
      protocol    = "tcp"
      description = "Allow 8082 docker container monitoring grafana"
    },
    {
      cidr_blocks = concat(var.mgt_subnets, var.bpd_prod_subnets)
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      description = "Allow port for elk monitoring"
    },
    {
      cidr_blocks = concat(var.prod_subnets, var.uat_subnets, var.dev_subnets, var.mgt_subnets, var.jenkins_subnets, var.bpd_prod_subnets)
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Allow port for accessing cma-postgres DB container"
    },

  ]
}
