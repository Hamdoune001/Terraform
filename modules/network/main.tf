# Network Module - Main File
# Documentation: Ce module crée une infrastructure réseau complète avec VPC, subnets, Internet Gateway, NAT Gateways et tables de routage

# Data source pour récupérer dynamiquement les zones de disponibilité disponibles dans la région
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Utilisation des zones de disponibilité disponibles (limité à 3)
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
  
  # Génération dynamique des CIDR blocks pour les sous-réseaux publics
  # Utilise la fonction cidrsubnet pour calculer les sous-réseaux
  public_subnet_cidrs = [
    for i in range(3) : cidrsubnet(var.vpc_cidr, 8, i)
  ]
  
  # Génération dynamique des CIDR blocks pour les sous-réseaux privés
  # Utilise la fonction cidrsubnet pour calculer les sous-réseaux
  private_subnet_cidrs = [
    for i in range(3) : cidrsubnet(var.vpc_cidr, 8, i + 3)
  ]
  
  # Tags communs pour toutes les ressources
  common_tags = merge(
    var.tags,
    {
      Module     = "network"
      Name       = var.vpc_name
      Terraform  = "true"
    }
  )
}
