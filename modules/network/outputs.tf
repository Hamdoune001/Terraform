# Network Module - Outputs
# Documentation: Valeurs de sortie du module réseau

output "vpc_id" {
  description = "ID du VPC créé"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block du VPC"
  value       = var.vpc_cidr
}

output "availability_zones" {
  description = "Zones de disponibilité utilisées"
  value       = local.availability_zones
}

output "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs des sous-réseaux privés"
  value       = aws_subnet.private[*].id
}

output "public_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux publics"
  value       = local.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "CIDR blocks des sous-réseaux privés"
  value       = local.private_subnet_cidrs
}

output "igw_id" {
  description = "ID de l'Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_ids" {
  description = "IDs des NAT Gateways créés"
  value       = var.enable_nat_gateway ? aws_nat_gateway.nat[*].id : []
}

output "nat_gateway_ips" {
  description = "Adresses IP Elastic des NAT Gateways"
  value       = var.enable_nat_gateway ? aws_eip.nat[*].public_ip : []
}

output "public_route_table_id" {
  description = "ID de la table de routage publique"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs des tables de routage privées"
  value       = aws_route_table.private[*].id
}
