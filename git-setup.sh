#!/bin/bash
# Script pour initialiser Git et pousser le code sur un dépôt distant

# Couleurs pour les messages
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Configuration de Git pour le TP Terraform${NC}"

# Vérifier si Git est installé
if ! command -v git &> /dev/null; then
    echo "Git n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Initialiser le dépôt Git s'il n'existe pas déjà
if [ ! -d .git ]; then
    echo -e "${GREEN}Initialisation du dépôt Git...${NC}"
    git init
else
    echo -e "${YELLOW}Le dépôt Git existe déjà.${NC}"
fi

# Créer un fichier .gitignore
echo -e "${GREEN}Création du fichier .gitignore...${NC}"
cat > .gitignore << EOF
# Fichiers Terraform
.terraform/
*.tfstate
*.tfstate.backup
*.tfstate.lock.info
*.tfvars
.terraform.lock.hcl

# Fichiers de crash
crash.log

# Fichiers de logs
*.log

# Fichiers sensibles
*.pem
*.key
*.pub
secrets.tfvars

# Fichiers système
.DS_Store
Thumbs.db
EOF

# Ajouter tous les fichiers
echo -e "${GREEN}Ajout des fichiers au dépôt...${NC}"
git add .

# Faire le premier commit
echo -e "${GREEN}Création du premier commit...${NC}"
git commit -m "Initial commit - TP Terraform"

# Demander l'URL du dépôt distant
echo -e "${YELLOW}Veuillez entrer l'URL de votre dépôt Git distant (GitHub, GitLab, etc.):${NC}"
read -p "URL: " repo_url

if [ -z "$repo_url" ]; then
    echo -e "${YELLOW}Aucune URL fournie. Le code n'a pas été poussé sur un dépôt distant.${NC}"
    echo -e "${YELLOW}Vous pouvez le faire manuellement plus tard avec:${NC}"
    echo "git remote add origin <URL_DU_DEPOT>"
    echo "git push -u origin main"
else
    # Ajouter le dépôt distant
    echo -e "${GREEN}Ajout du dépôt distant...${NC}"
    git remote add origin $repo_url

    # Pousser le code
    echo -e "${GREEN}Envoi du code vers le dépôt distant...${NC}"
    git push -u origin main || git push -u origin master

    echo -e "${GREEN}Configuration Git terminée avec succès!${NC}"
    echo -e "${YELLOW}Votre code a été poussé vers: ${NC}$repo_url"
fi

echo -e "${GREEN}TP Terraform prêt à être utilisé!${NC}"
