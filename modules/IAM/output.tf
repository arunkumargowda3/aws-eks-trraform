output "cluster_role" {
  value = aws_iam_role.eks_cluster_role.arn

}

output "node_role" {
  value = aws_iam_role.nodegroup_iam_role.arn

}