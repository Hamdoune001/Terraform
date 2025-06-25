# Network Module - Routing Resources
# Documentation: Création des tables de routage et associations

# Création de la table de routage publique
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
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
  count  = 3
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat[count.index].id
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-private-route-table-${count.index + 1}"
      Type = "Private"
      AZ   = local.availability_zones[count.index]
    }
  )
}

# Association des sous-réseaux publics à la table de routage publique
resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Association des sous-réseaux privés aux tables de routage privées
resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
