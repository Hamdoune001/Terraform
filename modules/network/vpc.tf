# Network Module - VPC Resources
# Documentation: Création du VPC, Internet Gateway et sous-réseaux

# Création du VPC personnalisé
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = merge(
    local.common_tags,
    {
      Name = var.vpc_name
    }
  )
}

# Création de l'Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-igw"
    }
  )
}

# Création des sous-réseaux publics (un dans chaque zone de disponibilité)
resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnet_cidrs[count.index]
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
      Type = "Public"
      AZ   = local.availability_zones[count.index]
    }
  )
}

# Création des sous-réseaux privés (un dans chaque zone de disponibilité)
resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
      Type = "Private"
      AZ   = local.availability_zones[count.index]
    }
  )
}
