# TP Terraform - Infrastructure AWS avec VPC, Subnets, NAT Gateways et Tables de Routage
# Documentation: Ce fichier principal utilise le module réseau pour créer l'infrastructure

# Configuration du Provider AWS
provider "aws" {
  region = var.region
}

# Module Network - Création de l'infrastructure réseau complète
module "network" {
  source = "./modules/network"

  vpc_cidr          = var.vpc_cidr
  vpc_name          = "${var.project_name}-vpc"
  enable_nat_gateway = var.enable_nat_gateway
  tags              = var.tags
}

# Outputs pour référence
output "vpc_id" {
  description = "ID du VPC créé"
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block du VPC"
  value       = module.network.vpc_cidr
}

output "availability_zones" {
  description = "Zones de disponibilité utilisées"
  value       = module.network.availability_zones
}

output "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  value       = module.network.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux publics"
  value       = module.network.public_subnet_cidrs
}

output "private_subnet_ids" {
  description = "IDs des sous-réseaux privés"
  value       = module.network.private_subnet_ids
}

output "private_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux privés"
  value       = module.network.private_subnet_cidrs
}

output "nat_gateway_ips" {
  description = "Adresses IP Elastic des NAT Gateways"
  value       = module.network.nat_gateway_ips
}

output "public_route_table_id" {
  description = "ID de la table de routage publique"
  value       = module.network.public_route_table_id
}

output "private_route_table_ids" {
  description = "IDs des tables de routage privées"
  value       = module.network.private_route_table_ids
}
