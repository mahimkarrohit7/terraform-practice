variable "aws_region" {
  type = string
  description = "AWS region"
}
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
variable "private_subnet_cidrs" {
  type = list(string)
  description = "AWS region"
}
variable "az_count" {
  type    = string
}
variable "public_subnet_cidrs" {
  type    = list(string)
}
variable "one_nat_gateway_per_az" {
  type    = string
}
variable "enable_nat_gateway" {
  type    = string
}
