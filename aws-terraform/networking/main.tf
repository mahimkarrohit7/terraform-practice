resource "aws_vpc" "project_personal_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = "${var.name}-vpc"
    }
}
resource "aws_internet_gateway" "gw_personal" {
    vpc_id = aws_vpc.project_personal_vpc.id

    tags = {
        Name = "${var.name}-IGW"
    }
}
resource "aws_subnet" "public_subnet" {
    count = var.az_count
    vpc_id = aws_vpc.project_personal_vpc.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = local.azs[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.name}-public-subnet-${local.azs[count.index]}"
    }
}

resource "aws_subnet" "private_subnet" {
    count = var.az_count
    vpc_id = aws_vpc.project_personal_vpc.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = local.azs[count.index]
    tags = {
       Name = "${var.name}-private-subnet-${local.azs[count.index]}"
    }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_personal_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_personal.id
  }

  tags = { 
    Name = "${var.name}-public-rt" 
    }
}
resource "aws_route_table_association" "pub_sub_to_igw" {
    count = var.az_count
    subnet_id      = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_eip" "nat_eip" {
#   domain = "vpc"
# }
# resource "aws_nat_gateway" "nat_personal" {
#     allocation_id = aws_eip.nat_eip.id
#     subnet_id = aws_subnet.private_subnet[0].id
#     depends_on = [aws_internet_gateway.gw_personal]
#     tags = {
#         Name = "${var.name}-NATGw"
#     }
# }
# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.project_personal_vpc.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_personal.id
#   }

#   tags = { Name = "${var.name}-private-rt" }
# }
# resource "aws_route_table_association" "priv_sub_to_natgw" {
#     count = var.az_count
#     subnet_id      = aws_subnet.private_subnet[count.index].id
#     route_table_id = aws_route_table.private_route_table.id
# }