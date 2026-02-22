output "vpc_id" {
    description = "VPC ID we created"
    value = aws_vpc.project_personal_vpc.id
}
output "public_subnet_id" {
    description = "Subnet_id created in public availability zone"
    value = aws_subnet.public_subnet[*].id
}
output "private_subnet_id" {
    description = "Subnet_id created in private availability zone"
    value = aws_subnet.private_subnet[*].id
}
output "azs_used" {
  value = local.azs
}


output "debug_az_count" {
  value = var.az_count
}

output "debug_az_names" {
  value = data.aws_availability_zones.available.names
}

output "debug_local_azs" {
  value = local.azs
}