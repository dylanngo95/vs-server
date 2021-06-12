# Create VPC
resource "aws_vpc" "vs_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  #gives you an internal domain name
  enable_dns_hostnames = "true"
  #gives you an internal host name
  enable_classiclink = "false"
  instance_tenancy = "default"

  tags = {
    Name = "vs_vpc"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "vs_internet_gateway" {
  vpc_id = aws_vpc.vs_vpc.id

  tags = {
    Name = "VS Internet Gateway"
  }
}

# Create subnet
resource "aws_subnet" "vs_subnet_public" {
  vpc_id = aws_vpc.vs_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  # it makes this a public subnet
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "vs_subnet_public"
  }
}

resource "aws_subnet" "vs_subnet_private" {
  vpc_id = aws_vpc.vs_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  # it makes this a public subnet
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "vs_subnet_private"
  }
}

# Create route table and link to subnet, internet gateway
resource "aws_route_table" "vs_route_table_public" {
  vpc_id = aws_vpc.vs_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vs_internet_gateway.id
  }

  tags = {
    Name = "vs_route_table_public"
  }
}

resource "aws_route_table_association" "vs_route_table_public_vs_subnet_public" {
  subnet_id = aws_subnet.vs_subnet_public.id
  route_table_id = aws_route_table.vs_route_table_public.id
}

resource "aws_route_table" "vs_route_table_private" {
  vpc_id = aws_vpc.vs_vpc.id

  tags = {
    Name = "vs_route_table_private"
  }
}

resource "aws_route_table_association" "vs_route_table_private_vs_subnet_private" {
  subnet_id = aws_subnet.vs_subnet_private.id
  route_table_id = aws_route_table.vs_route_table_private.id
}
