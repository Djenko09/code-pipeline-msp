variable "vpc_id" {}

variable "gw_id" {}

variable "env" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "client_name" {}

variable "project_name" {}

variable "availablity_zones" {}

variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  type    = string
  default = "eu-west-1"
}
