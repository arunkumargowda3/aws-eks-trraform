
# very important URL for modules = https://registry.terraform.io/browse/modules?provider=aws

#Creating the Aws VPC

resource "aws_vpc" "eks-vpc" {
  cidr_block           = var.cidr_block_vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.app_name}-${var.env}-VPC"
    envirnoment = "${var.env}"
  }
}
