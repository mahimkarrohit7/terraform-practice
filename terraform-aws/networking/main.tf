resource "aws_vpc" "project_personal_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = var.name
    }
}

resource "aws_subnet" "public_subnet" {
    count = var.az_count
    vpc_id = aws_vpc.project_personal_vpc.id
    cidr_block = var.public_subnet_cidr[count.index]

    tags = {
        Name = "${var.name}-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    count = var.az_count
    vpc_id = aws_vpc.project_personal_vpc.id
    cidr_block = var.private_subnet_cidr[count.index]

    tags = {
        Name = "${var.name}-private-subnet"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.project_personal_vpc.id
    route {
        cidr_block = var.public_subnet_cidr
        gateway_id = aws_internet_gateway.project_personal_igw.id
    }

    tags = {
        Name = var.name
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.project_personal_vpc.id
    route {
        cidr_block = var.private_subnet_cidr
        gateway_id = aws_internet_gateway.project_personal_igw.id
    }

    tags = {
        Name = "${var.name}"
    }
}

resource "aws_internet_gateway" "gw_personal" {
    vpc_id = aws_vpc.project_personal_vpc.id

    tags = {
        Name = var.name
    }
}

resource "aws_internet_gateway_attachment" "gw_personal_attach" {
    internet_gateway_id = aws_internet_gateway.gw_personal.id
    vpc_id = aws_vpc.project_personal_vpc.id
}

resource "aws_route_table_association" "pub_sub_to_igw" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_nat_gateway" "nat_personal" {
    allocation_id = aws.eip.example.id
    subnet_id = aws_subnet.private_subnet.id

    tags = {
        Name = "gw NAT"
    }
}

resource "aws_route_table_association" "pub_sub_to_natgw" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}