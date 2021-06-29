resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = var.tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = var.tags
}

resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_a_cidr

  tags = {
    Name = "Public 1a"
  }

  depends_on = [aws_internet_gateway.gw]

}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "Public 1b"
  }

  depends_on = [aws_internet_gateway.gw]

}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_a_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "Private 1a"
  }

}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_b_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "Private 1b"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name      = "Kroton route table rt_public"
    Managedby = "Terraform"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "Kroton route table private"
    Managedby = "Terraform"
  }

}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rt_public.id

}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.rt_public.id

}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_private.id

}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private.id

}

resource "aws_eip" "web" {
  vpc = true

  instance                  = aws_instance.web.id
  associate_with_private_ip = "192.168.1.10"
  depends_on                = [aws_internet_gateway.gw]

  tags = {
    Name      = "Kroton elastic ip"
    Managedby = "Terraform"
  }
}
