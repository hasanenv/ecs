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

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id
  owner  = var.owner
}

module "acm" {
  source = "./modules/acm"

  domain_name = module.route_53.domain_name
  zone_id     = module.route_53.zone_id
  owner       = var.owner
}

module "alb" {
  source = "./modules/alb"

  security_group_id   = module.security_groups.alb_security_group_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  acm_certificate_arn = module.acm.certificate_arn
  owner               = var.owner
}

module "route_53" {
  source = "./modules/route_53"

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}