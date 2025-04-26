#koden finnes på https://registry.terraform.io/
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.17.0"
    }
  }
}
provider "azurerm" {
  # Configuration options
  features { #required
  }
}
resource "azurerm_resource_group" "fd-rg" {
  #name     = "rg-demo.we" #required
  name     = "rg-jhlm2.we" #required
  location = "West Europe" #required
}
resource "azurerm_storage_account" "sa-demo" {
  name                     = "jhl1976" #globalt unikt, kun småbokst og tall
  resource_group_name      = azurerm_resource_group.fd-rg.name #navn fra TF resource over
  location                 = azurerm_resource_group.fd-rg.location #tatt fra location over
  account_tier             = "Standard" #hastighet på lagring
  account_replication_type = "LRS" #billigste redundansnivå - lokal

  tags = {
    environment = "staging"
  }
}
#gå til målmappe i PowerShell, kjør "terraform init", i mappa opprettes filene .terraform og .terraform-lock-hcl
#etterpå må det logges på AZ (Connect-Azure.azcli)
#terraform plan (viser endringer som vil bli utført)
#terraform plan -out=main.tfplan (lager ei fil som viser endringene, gir sikkerhet og benyttes i CICD for å sikre at rette endringer blir gjort, husk versjonering av fil)
#terraform plan show main.tfplan (print av endringene i fila -> revider)
#terraform apply main.tfplan 
#terraform apply (implementerer endringer)
#terraform validate (syntax og konsistens i kode
#terraform fmt (standardisering og kosistens i kode i konfigurasjonsfiler )
