# Easy Notes - Azure IaC

Erstellt für den Kurs benötigte Azure Infrastruktur

- Ressourcengruppe
- Netzwerksicherheitsgruppe
- Vnet mit 2 Subnets (1 Subnet delegiert für MySQL Flexservers)
- MySQL Flexible Server
- Azure Kubernetes Service (Test)

## Vorbereitungen

- Azure Account einrichten -> Login mit Schulaccount -> Registrieren als Student (Die Kachel ganz rechts)
- Azure CLI installieren lokal
- Terraform CLI installieren lokal
- Git Repository klonen

## Anpassungen der Konfiguration

Folgendes MUSS angepasst werden:

variables.tf:
- Datenbankname
    variable "tf-db-name"

- MySQL User und Password für DB Admin
    variable "tf-db-admin-user"
    variable "tf-db-admin-password"

## Infrastruktur Deployment

```Shell

az login

az account set --subscription "<Your-Subscription-ID>"

cd <project-folder>

terraform init

terraform plan -out easynotes-iac.tfplan

terraform apply --auto-approve easynotes-iac.tfplan


```

## Infrastruktur löschen

```Shell

cd <project-folder>

terraform destroy --auto-approve easynotes-iac.tfplan


```