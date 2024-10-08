resource "aws_subnet" "private_subnet" {
  count                   = length(var.cidr_privite_subnet)
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = element(var.cidr_privite_subnet, count.index)
  availability_zone       = element(var.subnet_azs, count.index)
  map_public_ip_on_launch = false
  depends_on              = [aws_vpc.eks-vpc]
  tags = {
    Name        = "${var.app_name}-${var.env}-privite-subnet-${element(var.subnet_azs, count.index)}"
    envirnoment = "${var.env}"
  }
}
