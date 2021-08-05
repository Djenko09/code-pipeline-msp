variable "instance-type-jumpbox" {
  type    = string
  default = "t3.micro"
}

variable "instance-type-AppServer" {
  type    = string
  default = "m5.large"
}

variable "instance-type-LojaOnline" {
  type    = string
  default = "m5.large"
}

variable "App-Server-ami" {
  type    = string
  default = "ami-0a023b638fa5869e8"
}

variable "LojaOnline-ami" {
  type    = string
  default = "ami-0a023b638fa5869e8"
}

variable "Jumpbox-Ami" {
  type    = string
  default = "ami-0f3ff6bda1b805c81"
}

variable "SB_Prod_2_id" {}
variable "SB_Prod_1_id" {}
variable "AppServerSG_id" {}
variable "JumpboxSG_id" {}
variable "LojaOnlineSG_id" {}

variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  type    = string
  default = "eu-west-1"
}