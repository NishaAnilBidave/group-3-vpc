resource "aws_vpc" "vpc_group3" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc_group3"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.vpc_group3.id
  cidr_block = var.cidr_public_a
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.vpc_group3.id
  cidr_block = var.cidr_public_b
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public_b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id     = aws_vpc.vpc_group3.id
  cidr_block = var.cidr_public_c
  availability_zone = "ap-south-1c"


  tags = {
    Name = "public_c"
  }
}
resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.vpc_group3.id
  cidr_block = var.cidr_private_a
  availability_zone = "ap-south-1a"
   

  tags = {
    Name = "private_a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.vpc_group3.id
  cidr_block = var.cidr_private_b
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private_b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id     = aws_vpc.vpc_group3.id
  cidr_block = var.cidr_private_c
  availability_zone = "ap-south-1c"

  tags = {
    Name = "private_c"
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_group3.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet_gateway]
}
