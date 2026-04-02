  variable "python_app_vpc_cidr" {}
  variable "python_app_vpc_name" {}
  variable "python_app_public_cidr" {}
  variable "python_app_private_cidr" {}
  variable "python_app_av_zone1" {}


resource "aws_vpc" "python-app-vpc" {
    cidr_block = var.python_app_vpc_cidr
    tags = {
      Name = var.python_app_vpc_name
    }
  
}


resource "aws_subnet" "python-app-subnet-public" {
    vpc_id = aws_vpc.python-app-vpc.id
    count = length(var.python_app_public_cidr)
    cidr_block = element(var.python_app_public_cidr, count.index)
    availability_zone = element(var.python_app_av_zone1, count.index)
    tags = {
      Name = "dev-python-app-subnet-public-${count.index + 1}"
    }
}


resource "aws_subnet" "python-app-subnet-private" {
    vpc_id = aws_vpc.python-app-vpc.id
    count = length(var.python_app_private_cidr)
    cidr_block = element(var.python_app_private_cidr, count.index)
    availability_zone = element(var.python_app_av_zone1, count.index)
    tags = {
      Name = "dev-python-app-subnet-private-${count.index + 1}"
    }
}   


resource "aws_internet_gateway" "python-app-igw" {
  vpc_id = aws_vpc.python-app-vpc.id
  tags = {
    Name = "dev-python-app-igw"
  }
  
}


resource "aws_route" "python-app-route-public" {
  route_table_id = aws_vpc.python-app-vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.python-app-igw.id

}


resource "aws_route_table" "python-app-private-route-table" {
  vpc_id = aws_vpc.python-app-vpc.id

  tags = {
    Name = "dev-python-app-private-route-table"
  }
}


resource "aws_route_table_association" "public-route-table-association" {
  count = length(aws_subnet.python-app-subnet-public)
  subnet_id = aws_subnet.python-app-subnet-public[count.index].id  
  route_table_id = aws_vpc.python-app-vpc.default_route_table_id
  
}


resource "aws_route_table_association" "private-route-table-association" {
  count = length(aws_subnet.python-app-subnet-private)
  subnet_id = aws_subnet.python-app-subnet-private[count.index].id  
  route_table_id = aws_route_table.python-app-private-route-table.id 
  
}



# If you want to use networking components from module-2 then you can use below code and comment the above code.
#
/*

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
  
}       */