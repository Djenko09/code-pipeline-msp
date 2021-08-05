#LBPRODSG
resource "aws_security_group" "LB-Prod" {
  provider    = aws.region-master
  name        = "LB-Prod"
  description = "Prod Load Balancer Sec Group"
  vpc_id      = var.vpc_id
  ingress {
    description = "allow anyone on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "webmin"
    from_port   = 10000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["148.69.136.107/32"]
  }
  ingress {
    description = "allow anyone on port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#rds-launch-wizard-1
resource "aws_security_group" "rds-launch-wizard-1" {
  provider    = aws.region-master
  name        = "rds-launch-wizard-1"
  description = "rds-launch-wizard-1"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Aurora"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.AppServerSG.id]
  }
  ingress {
    description     = "Aurora"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.JumpboxSG.id] #TODO: sg jumpbox
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#AppServerSG
resource "aws_security_group" "AppServerSG" {
  provider    = aws.region-master
  name        = "AppServerSG"
  description = "AppServerSG"
  vpc_id      = var.vpc_id
  ingress {
    description     = "-"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  ingress {
    description = "FTP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["24.172.73.155/32"]
  }
  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.JumpboxSG.id]
  }
  ingress {
    description     = "webmin"
    from_port       = 10000
    to_port         = 10000
    protocol        = "TCP"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  ingress {
    description = "FTP"
    from_port   = 20
    to_port     = 21
    protocol    = "TCP"
    cidr_blocks = ["24.172.73.155/32"]
  }
  ingress {
    description = "Zabbix"
    from_port   = 10050
    to_port     = 10050
    protocol    = "TCP"
    cidr_blocks = ["34.251.217.155/32"]
  }
  ingress {
    description     = "-"
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#LojaOnlineRDS
resource "aws_security_group" "LojaOnlineRds" {
  provider    = aws.region-master
  name        = "LojaOnlineRds"
  description = "LojaOnlineRds"
  vpc_id      = var.vpc_id
  ingress {
    description     = "-"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  ingress {
    description     = "-"
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
    security_groups = [aws_security_group.JumpboxSG.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Jumbox
resource "aws_security_group" "JumpboxSG" {
  provider    = aws.region-master
  name        = "JumpboxSG"
  description = "JumpboxSG"
  vpc_id      = var.vpc_id
  ingress {
    description = "-"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "-"
    from_port   = 10050
    to_port     = 10050
    protocol    = "TCP"
    cidr_blocks = ["34.251.217.155/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#LojaOnline SG
resource "aws_security_group" "LojaOnlineSG" {
  provider    = aws.region-master
  name        = "LojaOnlineSG"
  description = "LojaOnlineSG"
  vpc_id      = var.vpc_id
  ingress {
    description     = "-"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  ingress {
    description = "FTP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["24.172.73.155/32"]
  }
  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.JumpboxSG.id]
  }
  ingress {
    description     = "webmin"
    from_port       = 10000
    to_port         = 10000
    protocol        = "TCP"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  ingress {
    description = "FTP"
    from_port   = 20
    to_port     = 21
    protocol    = "TCP"
    cidr_blocks = ["24.172.73.155/32"]
  }
  ingress {
    description = "Zabbix"
    from_port   = 10050
    to_port     = 10050
    protocol    = "TCP"
    cidr_blocks = ["34.251.217.155/32"]
  }
  ingress {
    description     = "-"
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    security_groups = [aws_security_group.LB-Prod.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
