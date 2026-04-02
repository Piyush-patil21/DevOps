resource "aws_route_table" "terra-public-route" {
  vpc_id = aws_vpc.terra-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-ig.id
  }
  tags = {
    Name = "${local.env}-public"
  }
}

resource "aws_route_table" "terra-private-route" {
  vpc_id = aws_vpc.terra-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra-nat.id
  }
  tags = {
    Name = "${local.env}-private"
  }
}

# Use this approach to associate multiple subnets with one route table
resource "aws_route_table_association" "route-public" {
  for_each = {
    public1 = aws_subnet.terra-subnet-public1.id
    # public2 = aws_subnet.terra-subnet-public2.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.terra-public-route.id
}

resource "aws_route_table_association" "route-private" {
  for_each = {
    private  = aws_subnet.terra-subnet-private.id
    private2 = aws_subnet.terra-subnet-private2.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.terra-private-route.id
}