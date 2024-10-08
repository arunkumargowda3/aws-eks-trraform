variable "cidr_block_vpc" {
  type        = string
  description = "this is the cidr block to cretae  vpc"
  sensitive   = true
}

variable "instance_tenancy" {
  default = "default"
}

variable "cidr_public_subnet" {
  type        = list(any)
  description = "cidrs for public subnets"
  sensitive   = true
}
variable "cidr_privite_subnet" {
  type        = list(any)
  description = "cidrs for private subnets"
  sensitive   = true
}

variable "subnet_azs" {
  type = list(any)
}

variable "app_name" {
  type        = string
  description = "name of the app"
}

variable "env" {
  type        = string
  description = "name of the environment"
}