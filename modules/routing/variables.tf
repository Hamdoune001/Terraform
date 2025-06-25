# Routing Module - Variables
# Documentation: Variables d'entrée pour le module de routage

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
}

variable "igw_id" {
  description = "ID de l'Internet Gateway"
  type        = string
}

variable "nat_gateway_ids" {
  description = "IDs des NAT Gateways"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs des sous-réseaux privés"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zones de disponibilité utilisées"
  type        = list(string)
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default     = {}
}
