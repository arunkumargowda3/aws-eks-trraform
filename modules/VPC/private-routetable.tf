
resource "aws_route_table" "private-routetable" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-private.id
  }

  depends_on = [aws_nat_gateway.nat-private]
  tags = {
    Name = "${var.app_name}-${var.env}-Private-routetable"
  }
}



resource "aws_route_table_association" "private-route" {
  count          = length(var.cidr_privite_subnet)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private-routetable.id
}
