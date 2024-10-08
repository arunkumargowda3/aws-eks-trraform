# RSA key of size 4096 bits
# terraform taint tls_private_key.rsa-4096-eksapp
resource "tls_private_key" "rsa-4096-eksapp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks-rsa-key" {
  key_name   = "${var.cluster_name}-${var.env}-key"
  public_key = tls_private_key.rsa-4096-eksapp.public_key_openssh
  tags = {
    Name = "${lower(var.cluster_name)}-${var.env}"
  }
}

resource "local_file" "eksapp_privatekey" {
  filename = "${lower(var.cluster_name)}-${var.env}.pem"
  #path of the key 
  sensitive_content = tls_private_key.rsa-4096-eksapp.private_key_pem
  file_permission   = "0600"
}
