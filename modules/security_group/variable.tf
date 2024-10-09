variable "cluster_name" {
  type    = string
  default = "fusions"
}
variable "env" {
  type        = string
  description = "name of the environment"
  default     = "prod"
}

variable "app_name" {
  type = string
}

variable "vpc_id" {
  description = "vpc id"
  #default     = null
}
variable "node_name" {
  type    = string
  default = "app-address-node"
}