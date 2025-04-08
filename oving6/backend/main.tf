terraform {
  backend "azurerm" {
      resource_group_name  = "rg-be-tfstate-jhl1"
      storage_account_name = "sabejhl1976"
      container_name       = "scbejhl1"
      key                  = "terraform.tfstate"
  }
  
  #backend "local" {  #
  #  path = "terraform.tfstate"
  #}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "random_string" "random_string" { #random string for SA name
  length  = 10
  upper   = false
  special = false
}

resource "azurerm_resource_group" "rg_backend" {
  name     = var.rg_backend_name
  location = var.rg_backend_location
}

resource "azurerm_storage_account" "sa_backend" {
  name                     = "${lower(var.sa_backend_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_backend.name
  location                 = azurerm_resource_group.rg_backend.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc_backend" {
  name = var.sc_backend_name
  storage_account_id    = azurerm_storage_account.sa_backend.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {} #tilstandbilde av config på nåværende tilkobling

resource "azurerm_key_vault" "kv_backend" {
  name                        = "kv-${lower(var.kv_backend_name)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg_backend.location
  resource_group_name         = azurerm_resource_group.rg_backend.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create"
    ]

    secret_permissions = [
      "Get", "List", "Set"
    ]

    storage_permissions = [
      "Get", "List", "Set"
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_accesskey" {
  name         = var.sa_backend_accesskey_name
  value        = azurerm_storage_account.sa_backend.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend.id
}

#sjekk om tfstate filer blir laget:
#az storage blob list --container-name "sett inn ditt container navn" --account-name "sitt SA navn" --output table