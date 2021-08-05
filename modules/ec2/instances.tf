#Get linux AMI ID using SSM Parameter endpoint in eu-west-1
data "aws_ssm_parameter" "AmazonLinuxAmi" {
  provider = aws.region-master
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

#Create key-pair for logging into EC2 Loja Online
resource "aws_key_pair" "master-key" {
  provider   = aws.region-master
  key_name   = "jumpbox"
  public_key = file("../keys/id_rsa.pub")
}

#Create EC2 Jumpbox
resource "aws_instance" "Jumpbox" {
  provider                    = aws.region-master
  ami                         = var.Jumpbox-Ami
  instance_type               = var.instance-type-jumpbox
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.JumpboxSG_id]
  subnet_id                   = var.SB_Prod_2_id

  tags = {
    AWSbackup = "Yes"
    Name      = "Jumpbox"
  }

}

#Create EC2 AppServerSG
resource "aws_instance" "AppServer" {
  provider                    = aws.region-master
  ami                         = var.App-Server-ami
  instance_type               = var.instance-type-AppServer
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.AppServerSG_id]
  subnet_id                   = var.SB_Prod_2_id

  tags = {
    AWSbackup = "Yes"
    Name      = "AppServer"
  }

}

#Create EC2 LojaOnline
resource "aws_instance" "LojaOnline" {
  provider                    = aws.region-master
  ami                         = var.LojaOnline-ami
  instance_type               = var.instance-type-AppServer
  key_name                    = aws_key_pair.master-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.LojaOnlineSG_id]
  subnet_id                   = var.SB_Prod_2_id

  tags = {
    Name = "LojaOnline"
  }

}


