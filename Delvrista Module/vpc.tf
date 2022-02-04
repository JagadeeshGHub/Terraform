#Creating VPC
resource "aws_vpc" "Delvrista_VPC" {
    cidr_block              = "10.0.0.0/16"
    instance_tenancy        = "default"
    enable_dns_hostnames    = "true"
    enable_dns_support      = "true"

    tags = {
      "Name" = "Delvrista_VPC"
    }
}

#Public Subnets
resource "aws_subnet" "Delvrista-PublicSubnet-1" {
    cidr_block                      = "10.0.1.0/24"
    vpc_id                          = aws_vpc.Delvrista_VPC.id
    map_customer_owned_ip_on_launch = "true"
    availability_zone               = data.aws_availability_zone.available.names[0]

    tags = {
      "Name" = "Delvrista-PublicSubnet-1"
    }
}

resource "aws_subnet" "Delvrista-PublicSubnet-2" {
    cidr_block                      = "10.0.2.0/24"
    vpc_id                          = aws_vpc.Delvrista_VPC.id
    map_customer_owned_ip_on_launch = "true"
    availability_zone               = data.aws_availability_zone.available.names[1]

    tags = {
      "Name" = "Delvrista-PublicSubnet-2"
    }
}

#Private Subnets
resource "aws_subnet" "Delvrista-PrivateSubnet-1" {
    cidr_block                      = "10.0.3.0/24"
    vpc_id                          = aws_vpc.Delvrista_VPC.id
    map_customer_owned_ip_on_launch = "true"
    availability_zone               = data.aws_availability_zone.available.names[0]

    tags = {
      "Name" = "Delvrista-PrivateSubnet-1"
    }
}

resource "aws_subnet" "Delvrista-PrivateSubnet-2" {
    cidr_block                      = "10.0.4.0/24"
    vpc_id                          = aws_vpc.Delvrista_VPC.id
    map_customer_owned_ip_on_launch = "true"
    availability_zone               = data.aws_availability_zone.available.names[1]

    tags = {
      "Name" = "Delvrista-PrivateSubnet-2"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "Delvrista-IGW" {
    vpc_id = aws_vpc.Delvrista_VPC.id

    tags = {
      "name" = "Delvrista-IGW"
    }
}

#Define External IP elastic ip
resource "aws_eip" "Delvrista-nat-eip" {
  vpc = true
}

#NAT Gateway
resource "aws_nat_gateway" "Delvrista-nat-gw" {
  allocation_id = aws_eip.Delvrista-nat-eip.id
  subnet_id     = aws_subnet.Delvrista-PrivateSubnet-1.id
  depends_on    = [aws_internet_gateway.Delvrista-IGW]
}

#Route Table
resource "aws_route_table" "Delvrista-Public-RouteTable" {
    vpc_id = aws_vpc.Delvrista_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Delvrista-IGW.id
    }
    
    tags = {
        Name    = "Delvrista-Public-RouteTable"
    }
}

resource "aws_route_table" "Delvrista-Private-RouteTable" {
    vpc_id = aws_vpc.Delvrista_VPC.id
    route {
        cidr_block      = "0.0.0.0/0"
        nat_gateway_id  = aws_nat_gateway.Delvrista-nat-gw.id
    }
    tags = {
        Name = "Delvrista-Private-RouteTable"
    }
}

#Route Table Association
resource "aws_route" "routetable-association-1" {
    subnet_id       = aws_subnet.Delvrista-PublicSubnet-1.id
    route_table_id  = aws_route_table.Delvrista-Public-RouteTable.id
}

resource "aws_route" "routetable-association-2" {
    subnet_id       = aws_subnet.Delvrista-PublicSubnet-2.id
    route_table_id  = aws_route_table.Delvrista-Public-RouteTable.id
}

resource "aws_route" "routetable-association-3" {
    subnet_id       = aws_subnet.Delvrista-PrivateSubnet-1.id
    route_table_id  = aws_route_table.Delvrista-Private-RouteTable.id
}

resource "aws_route" "routetable-association-4" {
    subnet_id       = aws_subnet.Delvrista-PrivateSubnet-2.id
    route_table_id  = aws_route_table.Delvrista-Private-RouteTable.id
}