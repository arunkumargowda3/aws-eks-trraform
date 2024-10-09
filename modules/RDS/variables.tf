variable "subnet_id_rds" {
  type = list(any)

}
variable "engine_version" {
  type = string
  #"8.0.35"
}


variable "vpc_security_group_ids_db" {
  type = list(any)

}

variable "app_name" {
  type        = string
  description = "name of the app"
}

variable "subnet_azs" {
  type = list(any)
}

variable "env" {
  type        = string
  description = "name of the environment"
}


