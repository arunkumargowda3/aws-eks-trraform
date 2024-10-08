
variable "cluster_name" {
  type = string
}

variable "app_name" {
  type        = string
  description = "name of the app"
}

variable "env" {
  type        = string
  description = "name of the environment"
}

variable "policy_arns_node" {
  description = "List of IAM policy ARNs to attach"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ]
}



variable "node_name" {
  type = string
}

