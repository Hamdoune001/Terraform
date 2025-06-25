# VPC Module - Variables
# Documentation: Variables d'entrée pour le module VPC

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

variable "az_count" {
  description = "Nombre de zones de disponibilité à utiliser (par défaut 3)"
  type        = number
  default     = 3
}

variable "enable_dns_support" {
  description = "Activer le support DNS dans le VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Activer les noms d'hôte DNS dans le VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Attribuer automatiquement une IP publique aux instances lancées dans les sous-réseaux publics"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default     = {}
}
