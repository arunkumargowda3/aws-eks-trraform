
variable "kube_version" {
  description = "The version of the kubernates"
  type        = string
}

variable "cluster_subnet" {
  type        = list(any)
  description = "cidrs for cluster subnets"
}
variable "node_subnet" {
  type        = list(any)
  description = "cidrs for node subnets"
}


variable "cluster_role_arn" {
  type = string

}
variable "node_role_arn" {

}

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

variable "auth_mode" {
  type    = string
  default = "API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  type = bool

}

variable "max_unavailable_node" {
  type = number

}

variable "aws_launch_template_id" {
}


variable "security_group_cluster" {
  type = list(string)
}


variable "node_name" {
  type    = string
  default = "app-address-node"
}

variable "desired_size" {
  description = "select the desired size node should  be create "
  type        = number

}

variable "min_size" {
  description = "select the min size node should  be create "
  type        = number

}

variable "max_size" {
  description = "select the max size node should  be create "
  type        = number

}

variable "cluster_timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  default = null
  # or provide a default value if needed (both will work)
}

variable "create" {
  description = "Controls if resources should be created (affects nearly all resources)"
  type        = bool
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      version = "v1.30.3-eksbuild.2"
    },
    {
      name    = "vpc-cni"
      version = "v1.18.3-eksbuild.2"
    },
    {
      name    = "eks-pod-identity-agent"
      version = "v1.3.2-eksbuild.2"
    }
  ]
}

