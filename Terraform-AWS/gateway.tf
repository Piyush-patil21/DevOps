# Internet Gateway
resource "aws_internet_gateway" "terra-ig" {
  vpc_id = aws_vpc.terra-vpc.id
  tags = {
    Name = "${local.env}-terra-igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "terra-eip" {
  #   domain = "vpc"
  tags = {
    Name = "${local.env}-nat"
  }
  depends_on = [aws_internet_gateway.terra-ig]

}

# NAT Gateway
resource "aws_nat_gateway" "terra-nat" {
  allocation_id = aws_eip.terra-eip.id
  subnet_id     = aws_subnet.terra-subnet-public1.id
  tags = {
    Name = "${local.env}-nat"
  }
  depends_on = [aws_internet_gateway.terra-ig]
}