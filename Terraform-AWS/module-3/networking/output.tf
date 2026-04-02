output "vpc_default_route" {
  value = aws_vpc.python-app-vpc.default_route_table_id

}

output "python_app_vpc_id" {
  value = aws_vpc.python-app-vpc.id
  
}

output "python_app_public_subnet_id" {
  value = aws_subnet.python-app-subnet-public.*.id
}

