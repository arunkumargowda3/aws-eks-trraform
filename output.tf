
output "region" {
  description = "AWS region"
  value       = var.aws_region
}

#EKS
output "eks_cluster_endpoints" {
  value = module.eks.cluster_endpoint

}

output "cluster_name" {
  value = module.eks.cluster_name

}

output "cluster_status" {
  value = module.eks.cluster_status

}

#RDS
output "mysql_data_base_end_pionts" {
  value = module.rds_mysql.endpoint_rds
  
}

output "mysql_version" {
  value = module.rds_mysql.mysql_version
  
}