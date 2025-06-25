@echo off
REM Script pour initialiser Git et pousser le code sur un dépôt distant sous Windows

echo Configuration de Git pour le TP Terraform

REM Vérifier si Git est installé
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Git n'est pas installe. Veuillez l'installer avant de continuer.
    exit /b 1
)

REM Initialiser le dépôt Git s'il n'existe pas déjà
if not exist .git (
    echo Initialisation du depot Git...
    git init
) else (
    echo Le depot Git existe deja.
)

REM Créer un fichier .gitignore
echo Creation du fichier .gitignore...
(
echo # Fichiers Terraform
echo .terraform/
echo *.tfstate
echo *.tfstate.backup
echo *.tfstate.lock.info
echo *.tfvars
echo .terraform.lock.hcl
echo.
echo # Fichiers de crash
echo crash.log
echo.
echo # Fichiers de logs
echo *.log
echo.
echo # Fichiers sensibles
echo *.pem
echo *.key
echo *.pub
echo secrets.tfvars
echo.
echo # Fichiers système
echo .DS_Store
echo Thumbs.db
) > .gitignore

REM Ajouter tous les fichiers
echo Ajout des fichiers au depot...
git add .

REM Faire le premier commit
echo Creation du premier commit...
git commit -m "Initial commit - TP Terraform"

REM Demander l'URL du dépôt distant
echo Veuillez entrer l'URL de votre depot Git distant (GitHub, GitLab, etc.):
set /p repo_url="URL: "

if "%repo_url%"=="" (
    echo Aucune URL fournie. Le code n'a pas ete pousse sur un depot distant.
    echo Vous pouvez le faire manuellement plus tard avec:
    echo git remote add origin ^<URL_DU_DEPOT^>
    echo git push -u origin main
) else (
    REM Ajouter le dépôt distant
    echo Ajout du depot distant...
    git remote add origin %repo_url%

    REM Pousser le code
    echo Envoi du code vers le depot distant...
    git push -u origin main || git push -u origin master

    echo Configuration Git terminee avec succes!
    echo Votre code a ete pousse vers: %repo_url%
)

echo TP Terraform pret a etre utilise!
pause
