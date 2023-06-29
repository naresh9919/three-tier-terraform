variable "name" {
  description = "Mandatory - Name of the application"
  default     = "presto-valere"
}

variable "env" {
  description = "Mandatory - name of the application environment"
  default     = "prod"
}

variable "AWS_REGION" {
  description = "Mandatory - AWS region when resouces should be created"
  default     = "us-east-1"
}

variable "tags" {
  description = "Mandatory - Name to be used on all resources as prefix"
  default = {
    Terraform = "true"
  }
}

#### VPC VARIABLES #########

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "192.0.0.0/16"
}

variable "prod_subnets" {
  description = "CIDR for bpd prod subnets"
  type        = list(string)
  default     = ["192.0.5.0/24", "192.0.7.0/24"]
}

variable "uat_subnets" {
  description = "CIDR for uat subnets"
  type        = list(string)
  default     = ["192.0.10.0/24", "192.0.11.0/24"]
}

variable "dev_subnets" {
  description = "CIDR for dev subnets"
  type        = list(string)
  default     = ["192.0.13.0/24", "192.0.15.0/24"]
}

variable "jenkins_subnets" {
  description = "CIDR for jenkins subnets"
  type        = list(string)
  default     = ["192.0.18.0/24", "192.0.19.0/24"]
}

variable "rds_subnets" {
  description = "CIDR for rds subnets"
  type        = list(string)
  default     = ["192.0.21.0/24", "192.0.22.0/24"]
}

variable "lb_subnets" {
  description = "CIDR for Load balancer subnets"
  type        = list(string)
  default     = ["192.0.61.0/24", "192.0.62.0/24"]
}

variable "mgt_subnets" {
  description = "CIDR for mgt subnets"
  type        = list(string)
  default     = ["192.0.91.0/24"]
}

variable "bpd_prod_subnets" {
  description = "CIDR for mgt subnets"
  type        = list(string)
  default     = ["10.0.91.0/24", "10.0.18.0/24"]
}


variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = true
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  default     = "stop"
}

variable "create_new_key_pair" {
  description = "Create a new key for logging in to the instance. Allowed values true/false"
  default     = false
}

variable "ssh_key_filename" {
  description = "If create_new_key_pair is true, provide public key file."
  default     = "~/.ssh/id_rsa.pub"
}

variable "key_pair_existing" {
  description = "If create_new_key_pair is false, provide existing key pair name here."
  default     = "valery_bpd_poc_key"
}

variable "ssh_key_pair_name" {
  description = "If create_new_key_pair is true, provide new key pair name here."
  default     = "valery_bpd_poc_key"
}

# # PROD Instance Definitation

variable "prod_instance_type" {
  description = "The type of instance to start"
  default     = "t3.small"
}

variable "prod_instance_count" {
  description = "Number of instances to launch"
  default     = 2
}

variable "prod_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
  default     = "ami-057ed5282e8f06cf4"
}

# # UAT Instance Definition

variable "uat_instance_type" {
  description = "The type of instance to start"
  default     = "t3.small"
}

variable "uat_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "uat_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
  default     = "ami-057ed5282e8f06cf4"
}

# # DEV Instance Definition

variable "dev_instance_type" {
  description = "The type of instance to start"
  default     = "t3.small"
}

variable "dev_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "dev_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
  default     = "ami-057ed5282e8f06cf4"
}

# # Jenkins Instance Definition

variable "jenkins_instance_type" {
  description = "The type of instance to start"
  default     = "t3.small"
}

variable "jenkins_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "jenkins_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
  default     = "ami-00e766d2dde2f6ae7"
}

# # Management Instance Definition

variable "mgt_instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "mgt_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "mgt_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
  default     = "ami-08c40ec9ead489470"
}

# ### PROD DATABASE VARIABLES ###

variable "prod_db_identifier" {
  description = "Name of the database master instance to be created"
  default     = "presto_valere_prod_db"
}

variable "prod_db_engine" {
  description = "DB engine"
  default     = "postgres"
}

variable "prod_db_version" {
  description = "DB Version"
  default     = "14.1"
}

variable "prod_db_instance_type" {
  description = "DB instance type"
  default     = "db.t4g.large"
}

variable "prod_db_storage" {
  description = "DB Instance Storage size"
  default     = 5
}

variable "prod_db_max_allocated_storage" {
  description = "DB Max Instance Storage size when autoscaling storage is enabled"
  default     = 0
}

variable "prod_database_name" {
  description = "Database Name"
  default     = "presto_valere_prod_db"
}

variable "prod_database_user" {
  description = "Database user or admin user"
  default     = "presto_valere_prod_user"
}

variable "prod_database_passwd" {
  description = "Database user/admin user password"
  default     = "RkQ9ljmJXCiREpydb8MkELYTfV7"
}

variable "prod_database_port" {
  description = "DB Port Number"
  default     = "5432"
}

variable "prod_db_parameters" {
  description = "A map of DB parameter options to apply For eg: pgroup_parameters = { character_set_server = utf8 }"
  type        = map(any)
  default     = {}
}

# ### UAT DEV DATABASE VARIABLES ###

variable "uat_dev_db_identifier" {
  description = "Name of the database master instance to be created"
  default     = "presto_valere_uat_db"
}

variable "uat_dev_db_engine" {
  description = "DB engine"
  default     = "postgres"
}

variable "uat_dev_db_version" {
  description = "DB Version"
  default     = "14.1"
}

variable "uat_dev_db_instance_type" {
  description = "DB instance type"
  default     = "db.t4g.large"
}

variable "uat_dev_db_storage" {
  description = "DB Instance Storage size"
  default     = 5
}

variable "uat_dev_db_max_allocated_storage" {
  description = "DB Max Instance Storage size when autoscaling storage is enabled"
  default     = 0
}

variable "uat_dev_database_name" {
  description = "presto_valere_uat_db"
  default     = "presto_valere_uat_db"
}

variable "uat_dev_database_user" {
  description = "presto_valere_uat_user"
  default     = "presto_valere_uat_user"
}

variable "uat_dev_database_passwd" {
  description = "Database user/admin user password"
  default     = "AKIAVLDAN3GZNHEB7CQT"
}

variable "uat_dev_database_port" {
  description = "DB Port Number"
  default     = "5432"
}

variable "uat_dev_db_parameters" {
  description = "A map of DB parameter options to apply For eg: pgroup_parameters = { character_set_server = utf8 }"
  type        = map(any)
  default     = {}
}


## CMA DEV Instance Definition

variable "cma_dev_instance_type" {
  description = "The type of instance to start"
  default     = "t3.small"
}

variable "cma_dev_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "cma_dev_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 22.04 Bionic amd64"
  default     = "ami-057ed5282e8f06cf4"
