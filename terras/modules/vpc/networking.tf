resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Test igw"
  }
}

resource "aws_subnet" "main-1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet1_cidr}"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Main-1"
  }
}

resource "aws_subnet" "main-2" {
  cidr_block = "${var.subnet2_cidr}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "Main-2"
  }
}

resource "aws_subnet" "priv-1" {
  cidr_block = "${var.subnet4_cidr}"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = false
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "Priv-1"
  }
}

resource "aws_subnet" "priv-2" {
  cidr_block = "${var.subnet3_cidr}"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = false
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "Priv-2"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = {
    Name = "public route table"
  }
}

resource "aws_route_table_association" "public_subnet1_assos" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.main-1.id
}

resource "aws_route_table_association" "public_subnet2_assos" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.main-2.id
}
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}