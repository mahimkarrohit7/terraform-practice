module "networking" {
  source = "./networking"
  project = var.project
  name     = var.name
  az_count = var.az_count
  public_subnet_cidr = var.private_subnet_cidrs
  private_subnet_cidr = var.private_subnet_cidrs
}

# module "ec2" {
#     source = "./ec2"
#     project = var.project
#     aws_region = var.aws_region

#     vpc_id = module.networking.vpc_id
#     public_subnet_ids = module.networking.public_subnet_ids
#     private_subnet_ids = module.networking.private_subnet_ids
# }