module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  owner                = var.owner
}

module "iam" {
  source = "./modules/iam"

  owner = var.owner
}

module "ecr" {
  source = "./modules/ecr"

  owner = var.owner
}