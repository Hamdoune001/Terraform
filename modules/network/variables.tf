# Network Module - Variables
# Documentation: Variables d'entrée pour le module réseau

variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
  default     = "main-vpc"
}

variable "enable_nat_gateway" {
  description = "Activer ou désactiver les NAT Gateways"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default     = {}
}
