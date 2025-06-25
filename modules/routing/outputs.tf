# Routing Module - Outputs
# Documentation: Valeurs de sortie du module de routage

output "public_route_table_id" {
  description = "ID de la table de routage publique"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs des tables de routage privées"
  value       = aws_route_table.private[*].id
}

output "route_table_details" {
  description = "Détails des tables de routage"
  value = {
    public = {
      id = aws_route_table.public.id
      routes = [
        {
          destination = "0.0.0.0/0"
          target     = "Internet Gateway (${var.igw_id})"
        }
      ]
    }
    private = [
      for i, rt in aws_route_table.private : {
        id = rt.id
        az = var.availability_zones[i]
        routes = [
          {
            destination = "0.0.0.0/0"
            target     = "NAT Gateway (${var.nat_gateway_ids[i]})"
          }
        ]
      }
    ]
  }
}
