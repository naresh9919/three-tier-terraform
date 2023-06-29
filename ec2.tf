resource "aws_key_pair" "key_pair" {
  count      = var.create_new_key_pair ? 1 : 0
  key_name   = var.ssh_key_pair_name
  public_key = file(var.ssh_key_filename)
}

# Prod Instances
module "prod-ec2" {
  source = "./modules/instances/"

  instance_count = var.prod_instance_count
  ami            = var.prod_ami
  instance_type  = var.prod_instance_type
  subnet_ids     = module.main-vpc.prod_subnets[*].id
  az_ids         = module.main-vpc.azs

  vpc_security_group_ids = module.prod-sg.sg[*].id

  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring_profile.name

  required_data_partition = true

  #  data_partitions = [
  #    {
  #      device_name = "/dev/sdf"
  #      device_size = 30
  #    }
  #  ]

  required_fixed_public_ip = false

  associate_public_ip_address          = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  name = var.name
  env  = var.env

  ec2_suffix = "prod-app"

  root_volume_size = 30

  key_pair_name = var.create_new_key_pair ? element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0) : var.key_pair_existing

  tags = var.tags
}

# Uat Instances
module "uat-ec2" {
  source = "./modules/instances/"

  instance_count = var.uat_instance_count
  ami            = var.uat_ami
  instance_type  = var.uat_instance_type
  subnet_ids     = module.main-vpc.uat_subnets[*].id
  az_ids         = module.main-vpc.azs

  vpc_security_group_ids = module.uat-sg.sg[*].id

  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring_profile.name

  required_data_partition = true

  #  data_partitions = [
  #    {
  #      device_name = "/dev/sdf"
  #      device_size = 30
  #    }
  #  ]

  required_fixed_public_ip = false

  associate_public_ip_address          = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  name = var.name
  env  = var.env

  ec2_suffix = "uat-app"

  root_volume_size = 30

  key_pair_name = var.create_new_key_pair ? element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0) : var.key_pair_existing

  tags = var.tags
}

# Dev Instances
module "dev-ec2" {
  source = "./modules/instances/"

  instance_count = var.dev_instance_count
  ami            = var.dev_ami
  instance_type  = var.dev_instance_type
  subnet_ids     = module.main-vpc.dev_subnets[*].id
  az_ids         = module.main-vpc.azs

  vpc_security_group_ids = module.dev-sg.sg[*].id

  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring_profile.name

  required_data_partition = true

  #  data_partitions = [
  #    {
  #      device_name = "/dev/sdf"
  #      device_size = 30
  #    }
  #  ]

  required_fixed_public_ip = false

  associate_public_ip_address          = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  name = var.name
  env  = var.env

  ec2_suffix = "dev-app"

  root_volume_size = 30

  key_pair_name = var.create_new_key_pair ? element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0) : var.key_pair_existing

  tags = var.tags
}

# Jenkins Instances
#module "jenkins-ec2" {
#  source = "./modules/instances/"

#  instance_count = var.jenkins_instance_count
#  ami            = var.jenkins_ami
#  instance_type  = var.jenkins_instance_type
#  subnet_ids     = module.main-vpc.jenkins_subnets[*].id
#  az_ids         = module.main-vpc.azs

#  vpc_security_group_ids = module.jenkins-sg.sg[*].id

#  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring_profile.name

#  required_data_partition = true

  #  data_partitions = [
  #    {
  #      device_name = "/dev/sdf"
  #      device_size = 30
  #    }
  #  ]

#  required_fixed_public_ip = false

#  associate_public_ip_address          = false
#  disable_api_termination              = false
#  instance_initiated_shutdown_behavior = "stop"

#  name = var.name
#  env  = var.env

#  ec2_suffix = "jenkins-app"

#  root_volume_size = 40

#  key_pair_name = var.create_new_key_pair ? element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0) : var.key_pair_existing

#  tags = var.tags
#}


# Management Instances
module "mgt-ec2" {
  source = "./modules/instances/"

  instance_count = var.mgt_instance_count
  ami            = var.mgt_ami
  instance_type  = var.mgt_instance_type
  subnet_ids     = module.main-vpc.mgt_subnets[*].id
  az_ids         = module.main-vpc.azs

  vpc_security_group_ids = module.mgt-sg.sg[*].id

  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring_profile.name

  required_data_partition = false

  required_fixed_public_ip = true

  associate_public_ip_address          = true
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  name = var.name
  env  = var.env

  ec2_suffix = "bastion-mgt"

  root_volume_size = 10

  key_pair_name = var.create_new_key_pair ? element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0) : var.key_pair_existing

  tags = var.tags
}

# CMA Dev Instances
module "cma-dev-ec2" {
  source = "./modules/instances/"

  instance_count = var.cma_dev_instance_count
  ami            = var.cma_dev_ami
  instance_type  = var.cma_dev_instance_type
  subnet_ids     = module.main-vpc.dev_subnets[*].id
  az_ids         = module.main-vpc.azs

  vpc_security_group_ids = module.cma-dev-sg.sg[*].id

  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring_profile.name

  required_data_partition = true

  required_fixed_public_ip = false

  associate_public_ip_address          = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  name = var.name
  env  = var.env

  ec2_suffix = "cma-dev-app"

  root_volume_size = 30

  key_pair_name = var.create_new_key_pair ? element(concat(aws_key_pair.key_pair.*.key_name, [""]), 0) : var.key_pair_existing

  tags = var.tags
}
