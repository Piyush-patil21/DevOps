resource "aws_vpc" "terra-vpc" {
  cidr_block = "172.168.0.0/20"
  // Enable DNS support because some add-on in EKS requires this to be true    
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${local.env}-terra-vpc"
  }
}

resource "aws_subnet" "terra-subnet-public1" {
  vpc_id                          = aws_vpc.terra-vpc.id
  cidr_block                      = "172.168.0.0/24"
  assign_ipv6_address_on_creation = false
  availability_zone               = local.zone1
  map_public_ip_on_launch         = "true"
  tags = {
    Name                                      = "${local.env}-terra-subnet1"
    "kubernetes.io / role / elb"                = 1
    "kubernetes.io/cluster/${local.eks_name}" = "owned"
  }
}

# resource "aws_subnet" "terra-subnet-public2" {
#     vpc_id = "${aws_vpc.terra-vpc.id}"
#     cidr_block = "172.168.4.0/24"
#     assign_ipv6_address_on_creation = false
#     availability_zone = "${local.zone1}"
#     map_public_ip_on_launch = "true"
#     tags = {
#       Name = "${local.env}-terra-subnet2"
#       kubernetes.io/role/elb = 1
#       "kubernetes.io/cluster/${local.eks_name}" = "owned"
#     }
# }

resource "aws_subnet" "terra-subnet-private" {
  vpc_id            = aws_vpc.terra-vpc.id
  cidr_block        = "172.168.8.0/24"
  availability_zone = local.zone2
  tags = {
    Name                                      = "${local.env}-terra-subnet3"
    "kubernetes.io / role / internal-elb"       = 1
    "kubernetes.io/cluster/${local.eks_name}" = "owned"
  }

}

# resource "aws_vpc_ipv4_cidr_block_association" "terra-secondary-cidr" {
#     vpc_id = "${aws_vpc.terra-vpc.id}"
#     cidr_block = "10.13.0.0/20"
# }

# resource "aws_subnet" "terra-subnet-secondary-cidr" {
#     vpc_id = "${aws_vpc.terra-vpc.id}"
#     cidr_block = "10.13.0.0/24"
# }
