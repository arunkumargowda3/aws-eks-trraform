resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_publicsubnet]
  tags = {
    Name = "${var.app_name}-${var.env}-ElasticIP"
  }
}

resource "aws_nat_gateway" "nat-private" {
  allocation_id = aws_eip.nat_eip.id

  #We can't use count.index because one elastic ip is attached to one subnet so
  subnet_id = element(aws_subnet.public_subnet.*.id, 1)
  # the below will create on the first public subnet
  #subnet_id = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name = "${var.app_name}-${var.env}-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_publicsubnet, aws_subnet.private_subnet, aws_subnet.private_subnet]
}
