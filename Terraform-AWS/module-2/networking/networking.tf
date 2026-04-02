  variable "vpc_cidr" {}
  variable "vpc_name" {}
  variable "vpc_public_cidr" {}
  variable "vpc_private_cidr" {}
  variable "av_zone1" {}


resource "aws_vpc" "demo-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.vpc_name
    }
  
}


resource "aws_subnet" "demo-subnet-public" {
    vpc_id = aws_vpc.demo-vpc.id
    count = length(var.vpc_public_cidr)
    cidr_block = element(var.vpc_public_cidr, count.index)
    availability_zone = element(var.av_zone1, count.index)
    tags = {
      Name = "dev-demo-subnet-public-${count.index + 1}"
    }
}


resource "aws_subnet" "demo-subnet-private" {
    vpc_id = aws_vpc.demo-vpc.id
    count = length(var.vpc_private_cidr)
    cidr_block = element(var.vpc_private_cidr, count.index)
    availability_zone = element(var.av_zone1, count.index)
    tags = {
      Name = "dev-demo-subnet-private-${count.index + 1}"
    }
}   


resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "dev-demo-igw"
  }
  
}


resource "aws_route" "demo-route-public" {
  route_table_id = aws_vpc.demo-vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.demo-igw.id

}


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "dev-private-route-table"
  }
}


resource "aws_route_table_association" "demo-public-route-table-association" {
  count = length(aws_subnet.demo-subnet-public)
  subnet_id = aws_subnet.demo-subnet-public[count.index].id  
  route_table_id = aws_vpc.demo-vpc.default_route_table_id
  
}


resource "aws_route_table_association" "demo-private-route-table-association" {
  count = length(aws_subnet.demo-subnet-private)
  subnet_id = aws_subnet.demo-subnet-private[count.index].id  
  route_table_id = aws_route_table.private-route-table.id 
  
}


