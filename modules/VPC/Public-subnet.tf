
resource "aws_subnet" "public_subnet" {
  count                   = length(var.cidr_public_subnet)
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = element(var.cidr_public_subnet, count.index)
  availability_zone       = element(var.subnet_azs, count.index)
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.eks-vpc]
  tags = {
    Name        = "${var.app_name}-${var.env}-public-subnet-${element(var.subnet_azs, count.index)}"
    envirnoment = "${var.env}"
  }
}
