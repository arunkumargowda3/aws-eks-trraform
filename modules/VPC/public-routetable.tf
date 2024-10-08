resource "aws_route_table" "public-routetable" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_publicsubnet.id
  }
  depends_on = [aws_internet_gateway.internet_publicsubnet]
  tags = {
    Name = "${var.app_name}-${var.env}-Public-routetable"
  }
}



resource "aws_route_table_association" "public-route" {
  count          = length(var.cidr_public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public-routetable.id
}