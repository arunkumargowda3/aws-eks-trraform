
variable "kube_version" {
  description = "The version of the kubernates"
  type        = string
  default     = 1.26

}
variable "aws_region" {
  type        = string
  description = "aws region where our resources going to create choose"
  default     = "us-east-1"
}


variable "cidr_block_vpc" {
  type        = string
  description = "this is the cidr block to cretae  vpc"
  default     = "10.0.0.0/16"
  sensitive   = true
}
variable "cidr_public_subnet" {
  type        = list(any)
  description = "cidrs for public subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  sensitive   = true
}

variable "cidr_privite_subnet" {
  type        = list(any)
  description = "cidrs for private subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
  sensitive   = true
}

variable "subnet_azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "cluster_name" {
  type    = string
  default = "fusions"
}

variable "node_name" {
  type    = string
  default = "app-address-node"
}

variable "app_name" {
  type        = string
  description = "name of the app"
  default     = "addressbook"
}

variable "env" {
  type        = string
  description = "name of the environment"
  default     = "prod"
}

variable "create" {
  description = "Controls if resources should be created (affects nearly all resources)"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  type        = string
  description = "Selecting the type of tenancy for VPC"
  default     = "default"
}

variable "image_id_for_node" {
  type    = string
  default = ""

}
variable "instance_type_node" {
  type    = string
  default = "t3.medium"

}

variable "volume_size_ec2_nodes" {
  type    = number
  default = 40

}

variable "type_volume" {
  type    = string
  default = "gp2"

}

variable "desired_size" {
  description = "select the desired size node should  be create "
  type        = number
  default     = 2

}

variable "min_size" {
  description = "select the min size node should  be create "
  type        = number
  default     = 2

}

variable "max_size" {
  description = "select the max size node should  be create "
  type        = number
  default     = 4

}

variable "bootstrap_cluster_creator_admin_permissions" {
  type    = bool
  default = false
}

variable "max_unavailable_node" {
  type    = number
  default = 1

}


####EC2
variable "ami_ec2" {
  type    = string
  default = "ami-0fff1b9a61dec8a5f"
}

variable "instance_type_ec2" {
  type    = string
  default = "t2.micro"
}

#RDS DATABASE
variable "engine_version" {
  type    = string
  default = "8.0.35"
}
