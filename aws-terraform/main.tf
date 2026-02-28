module "networking" {
  source = "./networking"
  project = var.project
  name     = var.name
  vpc_cidr = var.vpc_cidr
  az_count = var.az_count
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "infra-bootstrap" {
  source = "./infra-bootstrap"
  project = var.project
  name     = var.name
  # vpc_cidr = var.vpc_cidr
  # az_count = var.az_count
  # public_subnet_cidrs = var.public_subnet_cidrs
  # private_subnet_cidrs = var.private_subnet_cidrs
}

module "compute" {
  source = "./compute"
  project = var.project
  name     = var.name
  instance_count = var.instance_count
  vpc_cidr = module.networking.vpc_id
  az_count = var.az_count
  public_subnet_id = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
}
