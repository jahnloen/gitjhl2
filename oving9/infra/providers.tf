terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-be-tfstate-jhl1"
    storage_account_name = "sa"
    container_name       = "scbejhl1"
    key                  = "jhl.terraform.tfstate" #ikke overskrive eksiterende backend tfstate
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