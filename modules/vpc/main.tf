# VPC Module - Main Resources
# Documentation: Ce module crée un VPC avec des sous-réseaux publics et privés dans 3 zones de disponibilité

# Data source pour récupérer dynamiquement les zones de disponibilité disponibles dans la région
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Utilisation des zones de disponibilité disponibles (limité au nombre spécifié par az_count)
  availability_zones = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  
  # Génération dynamique des CIDR blocks pour les sous-réseaux publics
  # Utilise la fonction cidrsubnet pour calculer les sous-réseaux
  public_subnet_cidrs = [
    for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i)
  ]
  
  # Génération dynamique des CIDR blocks pour les sous-réseaux privés
  # Utilise la fonction cidrsubnet pour calculer les sous-réseaux
  private_subnet_cidrs = [
    for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i + var.az_count)
  ]
  
  # Tags communs pour toutes les ressources
  common_tags = merge(
    var.tags,
    {
      Module     = "vpc"
      Name       = var.vpc_name
      Terraform  = "true"
    }
  )
}

# Création du VPC personnalisé
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  
  tags = merge(
    local.common_tags,
    {
      Name = var.vpc_name
    }
  )
}

# Création de l'Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}

# Création des sous-réseaux publics (un dans chaque zone de disponibilité)
resource "aws_subnet" "public" {
  count                   = var.az_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnet_cidrs[count.index]
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
      Type = "Public"
      AZ   = local.availability_zones[count.index]
    }
  )
}

# Création des sous-réseaux privés (un dans chaque zone de disponibilité)
resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
      Type = "Private"
      AZ   = local.availability_zones[count.index]
    }
  )
}
