resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = var.vpc_name
    }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
}