variable "env" {}

variable "vpc_id" {}

variable "client_name" {}

variable "authorized_ips" {
  type = map

  default = {}
}

variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  type    = string
  default = "eu-west-1"
}


