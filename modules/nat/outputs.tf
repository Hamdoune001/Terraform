# NAT Module - Outputs
# Documentation: Valeurs de sortie du module NAT Gateway

output "nat_gateway_ids" {
  description = "IDs des NAT Gateways créés"
  value       = aws_nat_gateway.nat[*].id
}

output "nat_gateway_ips" {
  description = "Adresses IP Elastic des NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "nat_gateway_details" {
  description = "Détails des NAT Gateways avec leurs zones de disponibilité"
  value = [
    for i, nat in aws_nat_gateway.nat : {
      id = nat.id
      ip = aws_eip.nat[i].public_ip
      az = var.availability_zones[i]
      subnet_id = var.public_subnet_ids[i]
    }
  ]
}
