resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support   = "true"
}

resource "aws_subnet" "Public_Subnet" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "ap-south-1a"

  tags = {
    Name = "publicsubnet"
  }
}

resource "aws_subnet" "Private_Subnet" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "10.0.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "ap-south-1b"

  tags = {
    Name = "privatesubnet"
  }
}

resource "aws_subnet" "Private_Subnet2" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone       = "ap-south-1c"

  tags = {
    Name = "privatesubnet2"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "publicroute" {
    vpc_id = aws_vpc.myvpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "publicroute"
  }
}

resource "aws_route_table_association" "routeass" {
    subnet_id = aws_subnet.Public_Subnet.id
    route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table" "privateroute1" {
    vpc_id = aws_vpc.myvpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "privateroute"
  }
}

resource "aws_route_table_association" "routeass" {
    subnet_id = aws_subnet.Public_Subnet.id
    route_table_id = aws_route_table.publicroute.id
}