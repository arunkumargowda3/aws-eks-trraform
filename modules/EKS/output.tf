
output "cluster_endpoint" {
  description = "The endpoint for the EKS control plane"
  value       = aws_eks_cluster.eks_cluster[0].endpoint
}
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster[0].id
}

output "cluster_status" {
  description = "The current status of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster[0].status
}
