output "LB-Prod_id" {
  value = aws_security_group.LB-Prod.id
}

output "rds-launch-wizard-1_id" {
  value = aws_security_group.rds-launch-wizard-1.id
}

output "AppServerSG_id" {
  value = aws_security_group.AppServerSG.id
}

output "LojaOnlineRds_id" {
  value = aws_security_group.LojaOnlineRds.id
}

output "JumpboxSG_id" {
  value = aws_security_group.JumpboxSG.id
}

output "LojaOnlineSG_id" {
  value = aws_security_group.LojaOnlineSG.id
}


