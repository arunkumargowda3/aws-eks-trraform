# IAM Policy for ASG, External DNS, ECR, AppMesh, and ALB Ingress access
resource "aws_iam_policy" "nodegroup_iam_policy" {
  name        = "${var.app_name}-${var.env}-nodegroupPolicy"
  description = "IAM Policy for ASG, External DNS, ECR, AppMesh, and ALB Ingress access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # ASG Access
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "eks:DescribeNodegroup"
        ]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ]
        Resource = ["*"]
      },
      # External DNS Access
      {
        Effect   = "Allow"
        Action   = [
          "route53:ChangeResourceRecordSets",
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ]
        Resource = "*"
      },
      # Full ECR Access
      {
        Effect   = "Allow"
        Action   = ["ecr:*"]
        Resource = "*"
      },
      # AppMesh Access
      {
        Effect   = "Allow"
        Action   = ["appmesh:*"]
        Resource = "*"
      },
      # ALB Ingress Access
      {
        Effect   = "Allow"
        Action   = ["elasticloadbalancing:*"]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "nodegroup_iam_role" {
  #count = local.create ? 1 : 0
  name = "${var.app_name}-${var.env}-nodegrouprole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    Name        = "${var.app_name}-${var.env}-nodegrouprole"
    environment = "${var.env}"
  }
}

locals {
  policy = var.policy_arns_node
}


#here policy_arn directly taken from the policy as above mentioned so no need to mention the arn directly beacuse its in json formate 
resource "aws_iam_role_policy_attachment" "nodegroup_iam_role" {
  policy_arn = aws_iam_policy.nodegroup_iam_policy.arn
  role       = aws_iam_role.nodegroup_iam_role.name
}


resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  for_each = toset(local.policy)

  policy_arn = each.key
  role       = aws_iam_role.nodegroup_iam_role.name
}
