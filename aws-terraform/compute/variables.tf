# variable "aws_region" {
#   type = string
#   description = "AWS region"
# }
variable "project" {
  type    = string
  default = "personal-lab"
}
variable "name" {
  type    = string
}
variable "vpc_cidr" {
  type = string
  description = "AWS region"
}
variable "public_subnet_id" {
  type = list(string)
}
variable "private_subnet_id" {
  type = list(string)
}
variable "az_count" {
  type    = string
}
variable "instance_count" {
  type    = number
}
variable "create_data_volume" {
  type = bool
  default = true
}
variable "data_volume_size" {
  type = number
  default = 10
}
variable "root_volume_size" {
  type = number
  default = 10
}
variable "volume_type" {
  type = string
  default = "gp3"
}
variable "volume_encrypted" {
  type = bool
  default = true
}
# variable "one_nat_gateway_per_az" {
#   type    = string
# }
# variable "enable_nat_gateway" {
#   type    = string
# }
