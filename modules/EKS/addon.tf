resource "aws_eks_addon" "addons" {
  count = length(aws_eks_cluster.eks_cluster) > 0 ? length(var.addons) : 0

  cluster_name                = aws_eks_cluster.eks_cluster[0].name
  addon_name                  = var.addons[count.index].name
  addon_version               = var.addons[count.index].version
  resolve_conflicts_on_update = "PRESERVE"
  depends_on = [
    aws_eks_cluster.eks_cluster,
  ]
}



/*

#because when i mentioned create = flase it will lot for the cluster when we apply it get a empty turp error
resource "aws_eks_addon" "addons" {
  #count          = length(aws_eks_cluster.eksprodapp) > 0 ? 1 : 0
  for_each          = { for addon in var.addons : addon.name => addon }
  # because of  count = local.create ? 1 : 0 
  cluster_name      = aws_eks_cluster.eksprodapp[0].name   
  #cluster_name   =   aws_eks_cluster.eksprodapp 
  addon_name        = each.value.name
  addon_version     = each.value.version
  resolve_conflicts_on_update = "PRESERVE"

  lifecycle {
    prevent_destroy = true
  }

depends_on = [
    aws_eks_cluster.eksprodapp,
  ]
}
*/