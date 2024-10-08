# IAM OIDC Provider
resource "aws_iam_openid_connect_provider" "oidc_provider" {
  count          = length(aws_eks_cluster.eks_cluster) > 0 ? 1 : 0
  client_id_list = ["sts.amazonaws.com"]

  /*If you are sure that there will always be only one identity block and one OIDC configuration, you can safely use the [0] index. However, if there's a chance you might have multiple configurations, you may want to loop through them or handle them accordingly.*/
  #url = aws_eks_cluster.eksprodapp.identity.0.oidc.0.issuer for multipal 

  #url            = aws_eks_cluster.eksprodapp.identity[0].oidc[0].issuer  
  # #changed because because of  count = local.create ? 1 : 0 
  #url = aws_eks_cluster.eksprodapp[0].identity[0].oidc[0].issuer
  url = aws_eks_cluster.eks_cluster[0].identity[0].oidc[0].issuer
  # use when count = local.create ? 1 : 0  above
  #url = "https://oidc.eks.${var.aws_region}.amazonaws.com/id/${aws_eks_cluster.eksprodapp.id}"
  # Default Amazon root CA thumbprint
  thumbprint_list = ["9e99a48a9960b14926bb7f3b21d936d6e1a1e4f9"]


  # Automatically approves the OIDC association
  depends_on = [aws_eks_cluster.eks_cluster]

  tags = {
    Name        = "${var.app_name}-${var.env}-oidc"
    envirnoment = "${var.env}"
  }
}