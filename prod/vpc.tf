resource "aws_vpc" "vs_vpc_prod" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  #gives you an internal domain name
  enable_dns_hostnames = "true"
  #gives you an internal host name
  enable_classiclink = "false"
  instance_tenancy = "default"

  tags = {
    Name = "vs-vpc-prod"
  }
}

resource "aws_subnet" "vs_subnet_prod_01" {
  vpc_id = aws_vpc.vs_vpc_prod.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  # it makes this a public subnet
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "vs-subnet-prod-01"
  }
}