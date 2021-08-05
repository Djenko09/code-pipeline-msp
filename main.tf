######################################
# VPC
######################################

module "vpc" {
  source              = "./modules/vpc"
  env                 = var.general.env
  client_name         = var.general.client_name
  project_name        = var.general.project_name
  domain_name_servers = var.general.domain_name_servers
  aws_region          = var.region-master
  cidr                = var.network.cidr_vpc

}

######################################
# Subnets
######################################

module "subnets" {
  source            = "./modules/subnets"
  env               = var.general.env
  client_name       = var.general.client_name
  project_name      = var.general.project_name
  aws_region        = var.region-master
  vpc_id            = module.vpc.vpc_id
  gw_id             = module.vpc.gw_id
  availablity_zones = var.network.availablity_zones
  # nat_gateway_enabled = "0" # If you dont need to create a Managed Nat Gateway. Set this value to 0

}

######################################
# Security Groups      
######################################

module "securitygroups" {
  source      = "./modules/securitygroups"
  vpc_id      = module.vpc.vpc_id
  env         = var.general.env
  client_name = var.general.client_name
}


######################################
# EC2 INSTANCES    
######################################

module "ec2_instances" {
  source          = "./modules/ec2"
  SB_Prod_2_id    = module.subnets.SB_Prod_2_id
  SB_Prod_1_id    = module.subnets.SB_Prod_1_id
  AppServerSG_id  = module.securitygroups.AppServerSG_id
  JumpboxSG_id    = module.securitygroups.JumpboxSG_id
  LojaOnlineSG_id = module.securitygroups.LojaOnlineSG_id

}

######################################
# Backup Plans   
######################################

module "awsbackup" {
  source       = "./modules/aws-backup"
  env          = var.general.env
  client_name  = var.general.client_name
  project_name = var.general.project_name
}

######################################
# ALB   
######################################

module "loadbalancer" {
  source     = "./modules/alb"
  SG-LB-Prod = module.securitygroups.LB-Prod_id
  SB-Prod-2  = module.subnets.SB_Prod_2_id
  SB-Prod-1  = module.subnets.SB_Prod_1_id
  vpc        = module.vpc.vpc_id
  Appserver  = module.ec2_instances.Appserver_id
  LojaOnline = module.ec2_instances.LojaOnline_id


}

######################################
# RDS 
######################################

#module "rds" {
 # source      = "./modules/rds"
  #subnetgroup = module.subnets.subnet_group
#}

