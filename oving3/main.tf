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
  subscription_id = var.subscription_id #må med etter v4.0
  features {                            #required
  }
}

resource "azurerm_resource_group" "rg-name" {
  name     = var.rg-name  #required
  location = var.location #required
}
resource "azurerm_storage_account" "saname" {
  name                     = var.saname                              #globalt unikt, kun småbokst og tall
  resource_group_name      = azurerm_resource_group.rg-name.name     #navn fra TF resource over
  location                 = azurerm_resource_group.rg-name.location #tatt fra location over
  account_tier             = var.account_tier                        #hastighet på lagring
  account_replication_type = var.account_replication_type            #billigste redundansnivå - lokal
}

resource "azurerm_network_security_group" "nsgname" { #gjenbruker ressursgruppa rg_name, og lager ikke egen denne gang
  name                = var.nsgname
  location            = azurerm_resource_group.rg-name.location
  resource_group_name = azurerm_resource_group.rg-name.name
}

resource "azurerm_virtual_network" "vnetname" {
  name                = var.vnetname
  location            = azurerm_resource_group.rg-name.location
  resource_group_name = azurerm_resource_group.rg-name.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  subnet {
    name             = var.subnet1
    address_prefixes = ["10.0.1.0/24"]
    security_group   = azurerm_network_security_group.nsgname.id
  }

  subnet {
    name             = var.subnet2
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.nsgname.id
  }


  tags = {
    environment = var.environment #f.eks. test, staging eller prod
  }
}
#gå til målmappe i PowerShell, kjør "terraform init", i mappa opprettes filene .terraform og .terraform-lock-hcl
#etterpå må det logges på AZ (Connect-Azure.azcli)
#terraform validate (sjekker syntax og konsistens i kode, samt kommer med forslag)
#terraform fmt (standardisering og kosistens i kode i konfigurasjonsfiler )
#terraform plan (viser endringer som vil bli utført)
#terraform plan -out=main.tfplan (lager ei fil som viser endringene, gir sikkerhet 
#og benyttes i CICD for å sikre at rette endringer blir gjort, husk versjonering av fil)
#terraform plan show main.tfplan (print av endringene i fila -> revider)
#terraform apply "main.tfplan" reviderete endringer kjøres ved hjelp av en main.tfplan fil
#terraform apply (implementerer endringer uten main.tfplan, dvs. ikke revidering

