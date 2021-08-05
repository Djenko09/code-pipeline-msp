#create VPC
resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Production"
  }

}
#Create IGW
resource "aws_internet_gateway" "Prod-IGW" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id

   tags = {
    Name = "ProductionIGW"
  }
  
}