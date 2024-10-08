

#terraform plan -var="create=false"
resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "${var.cluster_name}-${var.app_name}-${var.env}-cluster-${random_string.suffix.result}"
  create       = var.create
}

resource "aws_eks_cluster" "eks_cluster" {
  count    = local.create ? 1 : 0
  name     = local.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kube_version

  access_config {
    authentication_mode                         = var.auth_mode
    bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  }

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = var.security_group_cluster
    # In variable its should be defined as a null resources
    subnet_ids = var.cluster_subnet

  }

  timeouts {
    create = try(var.cluster_timeouts.create, null)
    update = try(var.cluster_timeouts.update, null)
    delete = try(var.cluster_timeouts.delete, null)
  }

  tags = {
    Name        = "${var.app_name}-${var.env}-cluster"
    envirnoment = "${var.env}"
  }

  lifecycle {
    ignore_changes = [
      access_config[0].bootstrap_cluster_creator_admin_permissions
    ]
    prevent_destroy = true
  }
}