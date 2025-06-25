# Network Module - NAT Gateway Resources
# Documentation: Création des NAT Gateways pour l'accès Internet des sous-réseaux privés

# Création des Elastic IPs pour les NAT Gateways (une par AZ)
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? 3 : 0
  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-nat-eip-${count.index + 1}"
      AZ   = local.availability_zones[count.index]
    }
  )
}

# Création des NAT Gateways (un dans chaque sous-réseau public)
resource "aws_nat_gateway" "nat" {
  count         = var.enable_nat_gateway ? 3 : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-nat-gateway-${count.index + 1}"
      AZ   = local.availability_zones[count.index]
    }
  )

  # Pour s'assurer que l'Internet Gateway est créé avant les NAT Gateways
  depends_on = [aws_internet_gateway.igw]
}
