resource "aws_vpc" "temp_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.tags, { Name = "${var.environment_name}-vpc" })
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_internet_gateway" "temp_igw" {
  vpc_id = aws_vpc.temp_vpc.id
  tags   = merge(var.tags, { Name = "${var.environment_name}-igw" })
}

resource "aws_subnet" "temp_public" {
  for_each                = { for idx, az in local.azs : az => local.public_subnets[idx] }
  vpc_id                  = aws_vpc.temp_vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = merge(var.tags,
  { Name = "${var.environment_name}-public-${each.key}" })
}

resource "aws_subnet" "temp_private" {
  for_each                = { for idx, az in local.azs : az => local.private_subnets[idx] }
  vpc_id                  = aws_vpc.temp_vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = merge(var.tags,
  { Name = "${var.environment_name}-private-${each.key}" })
}

resource "aws_eip" "temp_eip" {
  tags = merge(var.tags,
  { Name = "${var.environment_name}-eip" })
}

resource "aws_nat_gateway" "temp_nat" {
  allocation_id = aws_eip.temp_eip.id
  subnet_id     = values(aws_subnet.temp_public)[0].id
  tags = merge(var.tags,
  { Name = "${var.environment_name}-nat" })
  depends_on = [aws_internet_gateway.temp_igw]
}

resource "aws_route_table" "temp_publicrt" {
  vpc_id = aws_vpc.temp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.temp_igw.id
  }
  tags = merge(var.tags,
  { Name = "${var.environment_name}-publicrt" })
}

resource "aws_route_table_association" "temprt_assoc" {
  for_each       = aws_subnet.temp_public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.temp_publicrt.id
}

resource "aws_route_table" "temp_privatert" {
  vpc_id = aws_vpc.temp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.temp_nat.id
  }
  tags = merge(var.tags,
  { Name = "${var.environment_name}-privatert" })
}

resource "aws_route_table_association" "temprivatert_assoc" {
  for_each       = aws_subnet.temp_private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.temp_privatert.id
}

