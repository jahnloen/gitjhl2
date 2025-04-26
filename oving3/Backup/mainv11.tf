#koden finnes på https://registry.terraform.io/
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
  }
}
provider "azurerm" {
  # Configuration options
  #subscription_id = var.subscription_id #må med etter v4.0
  features {                            #required
  }
}
resource "azurerm_resource_group" "rg-name" {
  name     = var.rg-name                                              #required
  location = var.location                                             #required
}
resource "azurerm_storage_account" "saname" {
  name                     = var.saname                              #globalt unikt, kun småbokst og tall
  resource_group_name      = azurerm_resource_group.rg-name.name     #navn fra TF resource over
  location                 = azurerm_resource_group.rg-name.location #tatt fra location over
  account_tier             = var.account_tier                        #hastighet på lagring
  account_replication_type = var.account_replication_type            #billigste redundansnivå - lokal

  tags = {
    environment = var.environment                                     #f.eks. test, staging eller prod
  }
}
#gå til målmappe i PowerShell, kjør "terraform init", i mappa opprettes filene .terraform og .terraform-lock-hcl
#etterpå må det logges på AZ (Connect-Azure.azcli)
#terraform plan (viser endringer som vil bli utført)
#terraform plan -out=main.tfplan (lager ei fil som viser endringene, gir sikkerhet 
#og benyttes i CICD for å sikre at rette endringer blir gjort, husk versjonering av fil)
#terraform plan show main.tfplan (print av endringene i fila -> revider)
#terraform apply main.tfplan senere endringer kjøres ved hjelp av en main.tfplan fil
#terraform apply (implementerer endringer)
#terraform validate (syntax og konsistens i kode
#terraform fmt (standardisering og kosistens i kode i konfigurasjonsfiler )
