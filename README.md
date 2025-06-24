# Déploiement d'une application WordPress sur Azure avec Terraform et GitHub Actions

## 🧱 Architecture

Ce projet met en place une infrastructure cloud sur Azure avec :
- Un groupe de ressources (`azurerm_resource_group`)
- Un réseau virtuel avec sous-réseau (`azurerm_virtual_network`, `azurerm_subnet`)
- Une machine virtuelle Linux (Ubuntu) (`azurerm_linux_virtual_machine`)
- Une IP publique et un réseau associé
- Le déploiement de WordPress via un conteneur Docker, pushé sur Azure Container Registry (ACR)

> L'application WordPress utilise le thème **Astra**.

## ✅ Prérequis

Avant de démarrer :

- Avoir un abonnement Azure actif
- Avoir installé :
  - [Terraform](https://developer.hashicorp.com/terraform/downloads)
  - [Azure CLI](https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli)
  - [Git](https://git-scm.com/)
- Créer un **Azure Service Principal** et configurer les secrets GitHub suivants :

| Secret GitHub             | Description                          |
|---------------------------|--------------------------------------|
| `ARM_CLIENT_ID`           | ID du Service Principal              |
| `ARM_CLIENT_SECRET`       | Mot de passe (secret)                |
| `ARM_SUBSCRIPTION_ID`     | ID de l’abonnement Azure             |
| `ARM_TENANT_ID`           | ID du tenant Azure                   |
| `AZURE_CLIENT_ID`         | Pour l'authentification Docker       |
| `AZURE_CLIENT_SECRET`     | Pour l'authentification Docker       |
| `AZURE_TENANT_ID`         | Tenant Docker                        |
| `AZURE_SUBSCRIPTION_ID`   | Subscription Docker                  |

## 🚀 Étapes de déploiement

### 1. Initialisation du projet

```bash
git clone https://github.com/Yann-Ey/AZURE-TP2.git
cd AZURE-TP2
```

### 2. Initialisation Terraform

```bash
terraform init
```

### 3. Création du plan

```bash
terraform plan -var-file="terraform.tfvars"
```

### 4. Application du plan

```bash
terraform apply -auto-approve -var-file="terraform.tfvars"
```

> ⚠️ Le fichier `terraform.tfvars` doit être correctement rempli avec vos valeurs (ex: nom de ressource, SSH key, etc.).

### 5. Déploiement automatique via GitHub Actions

- À chaque `push` sur la branche `master`, deux workflows sont déclenchés :
  - `workflow_devoir2.yml` → déploiement Terraform
  - `workflow_docker.yml` → build & push de l'image Docker WordPress avec le thème Astra sur ACR
---
#### ❌ **Limitation actuelle**

> ⚠️ **Les GitHub Actions échouent actuellement**, principalement car le fichier `terraform.tfvars` n’est pas reconnu au moment du déploiement.
> En conséquence, **l'infrastructure ne se déploie pas automatiquement** depuis GitHub.

---

#### 📸 **Capture d'écran attendue**

> 🚫 *Pas de capture possible* car l’application WordPress **n’est pas encore fonctionnelle sur Azure** suite aux erreurs dans les GitHub Actions.

---

## 📦 Fichiers principaux

| Fichier / Dossier              | Rôle                                    |
|-------------------------------|-----------------------------------------|
| `main.tf`                     | Définition des ressources Azure         |
| `variables.tf`                | Déclaration des variables Terraform     |
| `terraform.tfvars`            | Valeurs des variables                   |
| `.github/workflows/`          | Contient les GitHub Actions             |
| `Dockerfile`                  | Image Docker personnalisée WordPress    |

## 🖼️ Thème WordPress

Le thème [Astra](https://wordpress.org/themes/astra/) est automatiquement installé et activé lors du déploiement du conteneur WordPress.
