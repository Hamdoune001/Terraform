# TP Terraform - Infrastructure AWS

Ce projet Terraform déploie une infrastructure AWS complète avec un VPC, des sous-réseaux publics et privés, des NAT Gateways et des tables de routage.

## Objectifs du TP

- Déployer une infrastructure AWS dans 3 zones de disponibilité (AZ) différentes
- Utiliser une data source pour récupérer dynamiquement les AZ disponibles
- Créer des subnets publics répartis sur ces 3 AZ
- Créer des subnets privés répartis sur ces 3 AZ
- Déterminer les CIDR blocks des subnets dynamiquement avec les fonctions Terraform

## Ressources créées

- Un VPC personnalisé
- Une Internet Gateway
- 3 NAT Gateways (un par AZ)
- Tables de routage (une publique et trois privées)
- 3 subnets publics (un par AZ)
- 3 subnets privés (un par AZ)

## Structure du projet

Le projet est organisé en modules pour une meilleure maintenabilité et réutilisabilité:

```
terraform/
├── main.tf                  # Fichier principal qui orchestre les modules
├── variables.tf             # Variables globales du projet
├── README.md                # Documentation du projet
└── modules/
    ├── vpc/                 # Module pour le VPC et les subnets
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── nat/                 # Module pour les NAT Gateways
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── routing/             # Module pour les tables de routage
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Fonctionnalités techniques

- **Data Sources**: Utilisation de `aws_availability_zones` pour récupérer dynamiquement les zones disponibles
- **Fonctions Terraform**: Utilisation de `cidrsubnet` pour calculer automatiquement les CIDR blocks des sous-réseaux
- **Méta-arguments**: Utilisation de `count` pour créer plusieurs ressources similaires
- **Expressions dynamiques**: Utilisation de boucles `for` pour générer des listes de valeurs
- **Tags**: Application cohérente de tags sur toutes les ressources

## Prérequis

- Terraform v1.0.0+
- AWS CLI configuré avec les credentials appropriés
- Accès à un compte AWS avec les permissions nécessaires

## Utilisation

1. Cloner le dépôt:
   ```bash
   git clone https://github.com/votre-username/terraform-tp.git
   cd terraform-tp
   ```

2. Initialiser Terraform:
   ```bash
   terraform init
   ```

3. Planifier le déploiement:
   ```bash
   terraform plan
   ```

4. Appliquer la configuration:
   ```bash
   terraform apply
   ```

5. Pour détruire l'infrastructure:
   ```bash
   terraform destroy
   ```

## Personnalisation

Vous pouvez personnaliser le déploiement en modifiant les variables dans le fichier `variables.tf`:

- `region`: Région AWS à utiliser
- `project_name`: Nom du projet, utilisé pour préfixer les ressources
- `environment`: Environnement (dev, staging, prod)
- `vpc_cidr`: CIDR block pour le VPC
- `az_count`: Nombre de zones de disponibilité à utiliser

## Résultats attendus

Après le déploiement, vous aurez:

1. Un VPC avec le CIDR block spécifié
2. 3 sous-réseaux publics avec accès Internet via l'Internet Gateway
3. 3 sous-réseaux privés avec accès Internet sortant via les NAT Gateways
4. Une table de routage publique et 3 tables de routage privées (une par AZ)

## Diagramme d'architecture

```
                                  +-------------------+
                                  |                   |
                                  |       VPC         |
                                  |  (10.0.0.0/16)    |
                                  |                   |
                                  +-------------------+
                                           |
                 +--------------------------|---------------------------+
                 |                          |                           |
        +------------------+       +------------------+        +------------------+
        |   AZ eu-west-1a  |       |   AZ eu-west-1b  |        |   AZ eu-west-1c  |
        +------------------+       +------------------+        +------------------+
                 |                          |                           |
        +------------------+       +------------------+        +------------------+
        | Public Subnet    |       | Public Subnet    |        | Public Subnet    |
        | (10.0.0.0/24)    |       | (10.0.1.0/24)    |        | (10.0.2.0/24)    |
        +------------------+       +------------------+        +------------------+
                 |                          |                           |
        +------------------+       +------------------+        +------------------+
        | NAT Gateway 1    |       | NAT Gateway 2    |        | NAT Gateway 3    |
        +------------------+       +------------------+        +------------------+
                 |                          |                           |
        +------------------+       +------------------+        +------------------+
        | Private Subnet   |       | Private Subnet   |        | Private Subnet   |
        | (10.0.3.0/24)    |       | (10.0.4.0/24)    |        | (10.0.5.0/24)    |
        +------------------+       +------------------+        +------------------+
```

## Auteur

TP Terraform - Formation AWS
