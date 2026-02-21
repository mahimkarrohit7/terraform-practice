module "networking" {
    source = "./networking"
    project = var.project
}

# module "ec2" {
#     source = "./ec2"
#     project = var.project
#     aws_region = var.aws_region

#     vpc_id = module.networking.vpc_id
#     public_subnet_ids = module.networking.public_subnet_ids
#     private_subnet_ids = module.networking.private_subnet_ids
# }