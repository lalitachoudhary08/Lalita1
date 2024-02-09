# Craete a vpc by using terraform
#vpc

resource "aws_vpc" "own_vpc" {
  cidr_block       = var.vpc_cider
  instance_tenancy = "default"

  tags = {
    Name = "var.vpc_name"
  }
}

#subnets
resource "aws_subnet" "public" {
  # count = 
  # availability_zone = 
  map_public_ip_on_launch = true
  vpc_id     = aws_vpc.own_vpc.id
  cidr_block = "var.pub_subnet_cidr"

  tags = {
    Name = "var.pub_subnet"
  }
}

resource "aws_subnet" "app" {
  #count =
  # availability_zone = 
  vpc_id = aws_vpc.own_vpc.id
  cidr_block = "var.app_subnet_cidr"

  tags = {
    Name = "var.aap_subnet"
  }

  
}

resource "aws_subnet" "data" {
  #count =
  # availability_zone =  
  vpc_id = aws_vpc.own_vpc.id
  cidr_block = "var.data_subnet_cidr"

  tags = {
    Name = "var.data_subnet"
  }

  
}

#igw

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.own_vpc.id

  tags = {
    Name = ""
  }
}

#nat-gw / eip

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.public[0 ].id

  tags = {
    Name = "var.vpc_name"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_own.id

  tags = {
    Name = "var.vpc_name"
  }
}

resource "aws_eip" "eip" {
  instance = var.vpc_name 
  domain   = "vpc"
}


#route table 

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.own_vpc.owner_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "var.vpc_name"
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.own_vpc.owner_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "var.vpc_name"
  }
}
#subnet association 

resource "aws_route_table_association" "private" {
  subnet_id      = [aws_subnet.public[*].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "aap" {
subnet_id      = [aws_subnet.private[2].id
  route_table_id = aws_route_table.public.id 

  }

resource "aws_route_table_association" "data" {
subnet_id      = [aws_subnet.private[2].id
  route_table_id = aws_route_table.private.id 

  }
