#Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}

#Create subnet "SB-Prod-1"
resource "aws_subnet" "SB-Prod-1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = var.vpc_id
  cidr_block        = "172.1.1.0/24"
  tags = {
    Name = "SB-Prod-1"
  }
}

#Create subnet "SB-Prod-2"
resource "aws_subnet" "SB-Prod-2" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = var.vpc_id
  cidr_block        = "172.1.2.0/24"
  tags = {
    Name = "SB-Prod-2"
  }
}

#Create route table SB-Prod-1
resource "aws_route_table" "SB-Prod-1" {
  provider = aws.region-master
  vpc_id   = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "SB-Prod-1"
  }
}

#Create route table SB-Prod-2
resource "aws_route_table" "SB-Prod-2" {
  provider = aws.region-master
  vpc_id   = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "SB-Prod-2"
  }
}

#Subnet Group
resource "aws_db_subnet_group" "default" {
  provider = aws.region-master
  name       = "main"
  subnet_ids = [aws_subnet.SB-Prod-2.id, aws_subnet.SB-Prod-1.id]
}

#Overwrite default route table of VPC(Master) with our route table entries
resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
  provider       = aws.region-master
  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.SB-Prod-1.id
}
