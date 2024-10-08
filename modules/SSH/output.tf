
output "ssh_keypair" {
  value = tls_private_key.rsa-4096-eksapp.private_key_pem
}


output "key_name" {
  value = aws_key_pair.eks-rsa-key.key_name
}
