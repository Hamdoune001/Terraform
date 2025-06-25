# NAT Module - Variables
# Documentation: Variables d'entrée pour le module NAT Gateway

variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs des sous-réseaux publics où les NAT Gateways seront créés"
  type        = list(string)
}

variable "igw_id" {
  description = "ID de l'Internet Gateway (pour la dépendance)"
  type        = string
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
