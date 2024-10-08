
resource "aws_internet_gateway" "internet_publicsubnet" {
  vpc_id     = aws_vpc.eks-vpc.id
  depends_on = [aws_subnet.public_subnet]

  tags = {
    Name = "${var.app_name}-${var.env}-IGW-Public"
  }
}
