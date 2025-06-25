# NAT Module - Main Resources
# Documentation: Ce module crée 3 NAT Gateways (un par zone de disponibilité)

locals {
  # Tags communs pour toutes les ressources
  common_tags = merge(
    var.tags,
    {
      Module     = "nat"
      Terraform  = "true"
    }
  )
}

# Création des Elastic IPs pour les NAT Gateways (une par AZ)
resource "aws_eip" "nat" {
  count  = length(var.public_subnet_ids)
  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-nat-eip-${count.index + 1}"
      AZ   = var.availability_zones[count.index]
    }
  )
}

# Création des NAT Gateways (un dans chaque sous-réseau public)
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-nat-gateway-${count.index + 1}"
      AZ   = var.availability_zones[count.index]
    }
  )

  # Pour s'assurer que l'Internet Gateway est créé avant les NAT Gateways
  depends_on = [var.igw_id]
}
