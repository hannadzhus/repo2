resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/24"
  tags       = local.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.0.0/26"
  availability_zone = "${local.region}a"

  tags = local.tags
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.0.64/26"
  availability_zone = "${local.region}b"

  tags = local.tags
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.0.128/26"
  availability_zone = "${local.region}c"

  

  tags = local.tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = local.tags
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = local.tags
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}


######

# resource "aws_route_table_association" "c" {
#   subnet_id      = aws_subnet.private_subnet-2.id
#   route_table_id = aws_route_table.rt.id
# }

######
resource "aws_eip" "nat_gateway" {
  vpc = true
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = local.tags

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = local.tags
}

resource "aws_route_table_association" "nat-rt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.nat.id
}


#######subnet2


# resource "aws_nat_gateway" "nat2" {
#   allocation_id = aws_eip.nat_gateway.id
#   subnet_id     = aws_subnet.private_subnet-2.id

#   tags = local.tags

#   depends_on = [aws_internet_gateway.gw]
# }

resource "aws_route_table" "nat2" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = local.tags
}

resource "aws_route_table_association" "nat-rt2" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.nat.id
}

########## network acl 

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.my-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

  # tags = {
  #   Name = "main"
  # }
}
# new changes

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = file(var.PUBLIC_KEY)
}
