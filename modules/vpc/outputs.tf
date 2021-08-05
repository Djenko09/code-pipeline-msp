output "vpc_id" {
  value = aws_vpc.vpc_master.id
}

output "gw_id" {
  value = aws_internet_gateway.Prod-IGW.id
}

output "main_route_table_id" {
  value = aws_vpc.vpc_master.main_route_table_id
}
