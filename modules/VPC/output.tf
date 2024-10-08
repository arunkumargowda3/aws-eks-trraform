output "id_of_vpc" {
  value = aws_vpc.eks-vpc.id
}
output "id_of_public_subnet" {
  value = aws_subnet.public_subnet[*].id
}

output "id_of_private_subnet" {
  value = aws_subnet.public_subnet[*].id
}
