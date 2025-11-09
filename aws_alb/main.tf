#1 vpc
resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "my-vpc"
  }
}

#2 public subnet
resource "aws_subnet" "my-public" {
  vpc_id            = aws_vpc.my-vpc.id
  count             = length(var.vpc_az)
  cidr_block        = cidrsubnet(aws_vpc.my-vpc.cidr_block, 8, count.index + 1)
  availability_zone = element(var.vpc_az, count.index)
  tags = {
    Name = "my-public-${count.index + 1}"
  }
}

#3 private subnet
resource "aws_subnet" "my-private" {
  vpc_id            = aws_vpc.my-vpc.id
  count             = length(var.vpc_az)
  cidr_block        = cidrsubnet(aws_vpc.my-vpc.cidr_block, 8, count.index + 3)
  availability_zone = element(var.vpc_az, count.index)
  tags = {
    Name = "my-private-${count.index + 1}"
  }
}

#4 igw
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "gips-igw"
  }
}

#5 public rt
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "my-public-rt"
  }
}

#6 public rt assoc
resource "aws_route_table_association" "my-rt-assc" {
  route_table_id = aws_route_table.my-rt.id
  count          = length(var.vpc_az)
  subnet_id      = element(aws_subnet.my-public[*].id, count.index)
}

#7 eip
resource "aws_eip" "my-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.my-igw]
}

#8 nat
resource "aws_nat_gateway" "my-nat" {
  subnet_id     = element(aws_subnet.my-private[*].id, 0)
  allocation_id = aws_eip.my-eip.id
  depends_on    = [aws_internet_gateway.my-igw]
  tags = {
    Name = "my-natgw"
  }
}

#9 RT for private
resource "aws_route_table" "my-private-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-nat.id
  }
  tags = {
    Name = "my-private-rt"
  }
}

#10 private rt assoc
resource "aws_route_table_association" "my-private-assc" {
  route_table_id = aws_route_table.my-private-rt.id
  count          = length(var.vpc_az)
  subnet_id      = element(aws_subnet.my-private[*].id, count.index)
}