# Routing Module - Main Resources
# Documentation: Ce module crée les tables de routage pour les sous-réseaux publics et privés

locals {
  # Tags communs pour toutes les ressources
  common_tags = merge(
    var.tags,
    {
      Module     = "routing"
      Terraform  = "true"
    }
  )
}

# Création de la table de routage publique
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-public-route-table"
      Type = "Public"
    }
  )
}

# Création des tables de routage privées (une par zone de disponibilité)
resource "aws_route_table" "private" {
  count  = length(var.nat_gateway_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_ids[count.index]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-private-route-table-${count.index + 1}"
      Type = "Private"
      AZ   = var.availability_zones[count.index]
    }
  )
}

# Association des sous-réseaux publics à la table de routage publique
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# Association des sous-réseaux privés aux tables de routage privées
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}
