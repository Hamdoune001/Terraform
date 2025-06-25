# VPC Module - Outputs
# Documentation: Valeurs de sortie du module VPC

output "vpc_id" {
  description = "ID du VPC créé"
  value       = aws_vpc.main.id
}

output "igw_id" {
  description = "ID de l'Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs des sous-réseaux privés"
  value       = aws_subnet.private[*].id
}

output "availability_zones" {
  description = "Zones de disponibilité utilisées"
  value       = local.availability_zones
}

output "vpc_cidr" {
  description = "CIDR block du VPC"
  value       = var.vpc_cidr
}

output "public_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux publics"
  value       = local.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux privés"
  value       = local.private_subnet_cidrs
}
