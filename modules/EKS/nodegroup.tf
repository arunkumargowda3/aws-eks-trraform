
resource "aws_eks_node_group" "eks_cluster_nodegroup" {
  count           = length(aws_eks_cluster.eks_cluster) > 0 ? 1 : 0
  cluster_name    = aws_eks_cluster.eks_cluster[0].name
  node_group_name = var.node_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.node_subnet[*]



  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  launch_template {

    id = var.aws_launch_template_id
    #when mention the version the starting letter shoud be capital i.e if default D or L
    version = "Default"
  }

  update_config {
    max_unavailable = var.max_unavailable_node
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_openid_connect_provider.oidc_provider,
    aws_eks_addon.addons,
  ]

  labels = {
    "env" = var.env
  }
  tags = {
    propagate_at_launch = true
    Name                = var.app_name
    envirnoment         = "${var.env}"
  }
  lifecycle {
    ignore_changes        = [scaling_config[0].desired_size,]
    create_before_destroy = true
  }
}