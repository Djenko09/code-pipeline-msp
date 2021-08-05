variable "aws_region" {}
variable "cidr" {}
variable "env" {}
variable "client_name" {}
variable "project_name" {}
variable "domain_name_servers" {}
variable "vpc_flow_logs" { default = "0" }
variable "flow_log_traffic_type" { default = "ALL" }
variable "tags" {
  type = map(string)

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

