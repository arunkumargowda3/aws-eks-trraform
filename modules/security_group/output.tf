output "id_security_cluster" {
  value = aws_security_group.cluster-sg[*].id

}


output "id_security_nodegroup" {
  value = aws_security_group.nodegroup-sg[*].id

}

output "id_ec2_security" {
  value = aws_security_group.ec2-sg[*].id
  
}

output "id_rds_security" {
  value = aws_security_group.database_security_group[*].id
  
}