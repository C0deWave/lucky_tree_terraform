resource "aws_vpc" "module_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "module_vpc_subnet_public1" {
  vpc_id            = aws_vpc.module_vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.vpc_name}_public1"
  }
}
resource "aws_subnet" "module_vpc_subnet_public2" {
  vpc_id            = aws_vpc.module_vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.vpc_name}_public2"
  }
}
resource "aws_subnet" "module_vpc_subnet_private1" {
  vpc_id            = aws_vpc.module_vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.vpc_name}_private1"
  }
}
resource "aws_subnet" "module_vpc_subnet_private2" {
  vpc_id            = aws_vpc.module_vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.vpc_name}_private2"
  }
}

resource "aws_internet_gateway" "module_vpc_ig" {
  vpc_id = aws_vpc.module_vpc.id
  tags = {
    Name="${aws_vpc.module_vpc.tags.Name}-ig"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.module_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.module_vpc_ig.id
  }

  tags = {
    Name = "${aws_vpc.module_vpc.tags.Name}_public_route_table"
  }
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id = aws_subnet.module_vpc_subnet_public1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id = aws_subnet.module_vpc_subnet_public2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.module_vpc.id
  route = []
  tags = {
    Name = "${aws_vpc.module_vpc.tags.Name}_private_route_table"
  }
}

resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id = aws_subnet.module_vpc_subnet_private1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id = aws_subnet.module_vpc_subnet_private2.id
  route_table_id = aws_route_table.private_route_table.id
}
