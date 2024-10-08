# Security Group for eks cluster
resource "aws_security_group" "cluster-sg" {
  vpc_id      = var.vpc_id
  name        = "${var.cluster_name}-${var.node_name}-${var.env}-Cluster-secgr"
  description = "Security Group for G2 instance"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ALL TRAFFIC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                        = "${var.cluster_name}-${var.node_name}-${var.env}-Cluster-secgrp"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Cluster_name                                = var.cluster_name
    envirnoment                                 = var.env
  }

  lifecycle {
    ignore_changes = [ingress,
    egress, ]
  }

}

##security group for node froup
resource "aws_security_group" "nodegroup-sg" {
  vpc_id      = var.vpc_id
  name        = "${var.cluster_name}-${var.node_name}-${var.env}-node-secgr"
  description = "Security Group for G2 instance"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Alltraffic"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ALL TRAFFIC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                        = "${var.cluster_name}-${var.node_name}-${var.env}-nodegroup-secgrp"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Cluster_name                                = var.cluster_name
    envirnoment                                 = var.env
  }

  lifecycle {
    ignore_changes = [ingress,
    egress, ]
  }
}
