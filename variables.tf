variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  type    = string
  default = "eu-west-1"
}

variable "external_ip" {
  type    = string
  default = "94.62.232.34/32"
}

variable "general" {
  default = {
    env                 = "prod"
    client_name         = "Compact Records"
    project_name        = "-"
    domain_name_servers = "127.0.0.1,AmazonProvidedDNS"
  }
}

variable "aws_provider" {
  default = {
    region      = "ap-southeast-2"
    credentials = "~/.aws/credentials"
  }
}

variable "network" {
  description = "Network variables"
  default = {
    cidr_vpc             = "172.1.0.0/16"
    availablity_zones    = "a,b,c"
    public_subnets_cidr  = ""
    private_subnets_cidr = ""
  }
}

variable "shared_tags" {
  description = "Shared Tags"

  default = {
    Terraform = "true"
  }
}
