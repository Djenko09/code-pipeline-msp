output "SB_Prod_2_id" {
  value = aws_subnet.SB-Prod-2.id
}

output "SB_Prod_1_id" {
  value = aws_subnet.SB-Prod-1.id
}

output "subnet_group"{
  value = aws_db_subnet_group.default.name
}
