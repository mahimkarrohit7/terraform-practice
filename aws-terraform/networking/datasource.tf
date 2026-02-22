data "aws_availability_zones" "available" {
  state = "available"
}

locals {
    azs = [
        for i, az in data.aws_availability_zones.available.names :
        az if i < var.az_count
    ]
}

# locals {
#   first_public_subnet_id = values(aws_subnet.public_subnet)[0].id
# }