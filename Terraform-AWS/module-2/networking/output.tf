output "vpc_default_route" {
  value = aws_vpc.demo-vpc.default_route_table_id

}

output "demo_vpc_id" {
  value = aws_vpc.demo-vpc.id
  
}

output "public_subnet_id" {
  value = aws_subnet.demo-subnet-public.*.id
}
