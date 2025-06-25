# TP Terraform - Infrastructure AWS avec VPC, Subnets, NAT Gateways et Tables de Routage
# Documentation: Ce fichier principal orchestre les différents modules pour créer l'infrastructure

# Configuration du Provider AWS
provider "aws" {
  region = var.region
}

# Module VPC - Création du VPC, Internet Gateway, et sous-réseaux
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr               = var.vpc_cidr
  vpc_name               = "${var.project_name}-vpc"
  az_count               = var.az_count
  enable_dns_support     = true
  enable_dns_hostnames   = true
  map_public_ip_on_launch = true
  tags                   = var.tags
}

# Module NAT - Création des NAT Gateways pour l'accès Internet des sous-réseaux privés
module "nat" {
  source = "./modules/nat"

  vpc_name          = "${var.project_name}-vpc"
  public_subnet_ids = module.vpc.public_subnet_ids
  igw_id            = module.vpc.igw_id
  availability_zones = module.vpc.availability_zones
  tags              = var.tags
}

# Module Routing - Création des tables de routage et associations
module "routing" {
  source = "./modules/routing"

  vpc_id             = module.vpc.vpc_id
  vpc_name           = "${var.project_name}-vpc"
  igw_id             = module.vpc.igw_id
  nat_gateway_ids    = module.nat.nat_gateway_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  availability_zones = module.vpc.availability_zones
  tags               = var.tags
}

# Outputs pour référence
output "vpc_id" {
  description = "ID du VPC créé"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block du VPC"
  value       = module.vpc.vpc_cidr
}

output "availability_zones" {
  description = "Zones de disponibilité utilisées"
  value       = module.vpc.availability_zones
}

output "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux publics"
  value       = module.vpc.public_subnet_cidrs
}

output "private_subnet_ids" {
  description = "IDs des sous-réseaux privés"
  value       = module.vpc.private_subnet_ids
}

output "private_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux privés"
  value       = module.vpc.private_subnet_cidrs
}

output "nat_gateway_ips" {
  description = "Adresses IP Elastic des NAT Gateways"
  value       = module.nat.nat_gateway_ips
}

output "nat_gateway_details" {
  description = "Détails des NAT Gateways"
  value       = module.nat.nat_gateway_details
}

output "route_table_details" {
  description = "Détails des tables de routage"
  value       = module.routing.route_table_details
}
