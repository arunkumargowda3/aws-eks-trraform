
variable "key_name" {
  type = string
}

variable "image_id_for_node" {
  type = string
}

variable "instance_type_node" {
  type = string

}

variable "cluster_name" {
  type = string
}
variable "node_name" {
  type = string
}

variable "env" {
  type        = string
  description = "name of the environment"
}


variable "volume_size_ec2_nodes" {
  type = number
}

variable "type_volume" {
  type = string

}
variable "ebs_termination" {
  type    = bool
  default = true
}

variable "ebs_optimized" {
  type    = bool
  default = true

}

variable "monitoring_ec2" {
  type    = bool
  default = true

}

variable "network_interfaces_associate_public_ip_address" {
  type    = bool
  default = true

}

variable "disable_api_stop" {
  type    = bool
  default = true

}

variable "disable_api_termination" {
  type    = bool
  default = true

}

variable "max_unavailable_node" {
  type    = number
  default = 1

}

variable "security_node_group_cluster" {
  type = list(string)
}

