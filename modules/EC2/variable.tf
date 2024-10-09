variable "ec2_subnets" {
  type        = list(any)
  description = "cidrs for ec2 subnets"
}


variable "security_group_ec2" {
  type = list(any)
}


variable "key_name" {
  type = string
}



variable "subnet_azs" {
  type = list(any)
}

variable "ami_ec2" {
  type = string
}

variable "instance_type_ec2" {
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