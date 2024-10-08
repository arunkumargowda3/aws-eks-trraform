output "id_security_cluster" {
  value = aws_security_group.cluster-sg[*].id

}


output "id_security_nodegroup" {
  value = aws_security_group.nodegroup-sg[*].id

}