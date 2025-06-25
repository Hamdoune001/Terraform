# Variables globales pour le projet Terraform
# Documentation: Variables d'entrée pour le projet Terraform

variable "region" {
  description = "Région AWS à utiliser"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Nom du projet, utilisé pour préfixer les ressources"
  type        = string
  default     = "terraform-demo"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Nombre de zones de disponibilité à utiliser"
  type        = number
  default     = 3
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "terraform-demo"
    Owner       = "TP-Terraform"
  }
}
