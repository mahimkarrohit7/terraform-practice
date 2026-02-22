variable "name" {
  type    = string
}

variable "aws_region" {
    type = string
    description = "AWS region"
    default = "ap-southeast-1"
}

variable "vpc_cidr" {
    type = string
    description = "AWS region"
    default = "ap-southeast-1"
}

variable "private_subnet_cidr" {
    type = list(string)
    description = "AWS region"
}

# variable "bucket_name" {
#     type = string
#     description = "s3 bucket name"
# }

variable "project" {
  type    = string
}

variable "az_count" {
  type    = string
}

variable "public_subnet_cidr" {
  type    = list(string)
}

