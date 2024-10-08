#terraform plan -var="create=false"
resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "${var.cluster_name}-${var.app_name}-${var.env}-cluster-${random_string.suffix.result}"
  create       = var.create
}


module "vpc" {
  source              = "./modules/VPC"
  cidr_block_vpc      = var.cidr_block_vpc
  cidr_public_subnet  = var.cidr_public_subnet
  cidr_privite_subnet = var.cidr_privite_subnet
  subnet_azs          = var.subnet_azs
  app_name            = var.app_name
  env                 = var.env
}

module "ssh" {
  source       = "./modules/SSH"
  cluster_name = var.cluster_name
  env          = var.env
}

module "security_group" {
  source     = "./modules/security_group"
  vpc_id     = module.vpc.id_of_vpc
  depends_on = [module.vpc]
}

module "iam" {
  source       = "./modules/IAM"
  node_name    = var.node_name
  cluster_name = var.cluster_name
  app_name     = var.app_name
  env          = var.env

  depends_on = [ module.vpc ]

}

module "aws_launch_template" {
  source                      = "./modules/aws_templete"
  key_name                    = module.ssh.key_name
  image_id_for_node           = var.image_id_for_node
  instance_type_node          = var.instance_type_node
  volume_size_ec2_nodes       = var.volume_size_ec2_nodes
  type_volume                 = var.type_volume
  security_node_group_cluster = module.security_group.id_security_nodegroup
  node_name                   = var.node_name
  cluster_name                = var.cluster_name
  env                         = var.env
  depends_on                  = [module.security_group, module.ssh]
}

module "eks" {
  source = "./modules/EKS"
  # EKS Cluster details
  kube_version                                = var.kube_version
  cluster_subnet                              = module.vpc.id_of_public_subnet
  security_group_cluster                      = module.security_group.id_security_cluster
  cluster_role_arn                            = module.iam.cluster_role
  create                                      = local.create
  bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  cluster_name                                = var.cluster_name
  app_name                                    = var.app_name
  env                                         = var.env

  #NODE GROUP DETAILS
  node_subnet            = module.vpc.id_of_public_subnet
  node_role_arn          = module.iam.node_role
  aws_launch_template_id = module.aws_launch_template.aws_launch_template
  desired_size           = var.desired_size
  min_size               = var.min_size
  max_size               = var.max_size
  max_unavailable_node   = var.max_unavailable_node
  depends_on             = [module.vpc, module.aws_launch_template, module.iam, module.security_group, module.ssh, ]
}






























/*
module "aws_eks_cluster" {
  source = "./modules/EKS"
  kube_version = var.kube_version
  create = local.create
  #security_group_node = [module.security.id_security_cluster]
  env = var.env
  app_name = var.app_name
  cluster_name = local.cluster_name
  auth_mode = var.auth_mode
  bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  cidr_public_subnet = module.vpc.id_of_public_subnet
  cidr_block = module.vpc.id_of_vpc
  cidr_subnet = module.vpc.id_of_public_subnet
  #cidr_subnet = module.vpc.id_of_private_subnet[*]
  max_unavailable_node= var.max_unavailable_node
  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size

  
}
*/