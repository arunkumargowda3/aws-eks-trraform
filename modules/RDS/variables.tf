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

variable "encoded_username" {
  default = "YWRtaW5vcHM="
}

variable "encoded_password" {
  default = "YWRtaW5vcHNAMTIzNA=="
}

#echo -n 'dbpassword11' | base64
#URL: https://www.base64encode.org
#echo "YWRtaW5wYXNzd29yZA==" | base64 --decode

