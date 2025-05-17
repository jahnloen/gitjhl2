terraform {
  required_version = ">= 1.0" #constrain which versions of the Terraform CLI can be used with your configuration

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
    
    template = {
      source  = "hashicorp/template"
      version = "~> 2"  #larger than v2
    }
    
    random = {
      source  = "hashicorp/random"
      version = "~> 3"   #requires larger than v3
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-be-tfstate-jhl1"
    storage_account_name = "sabejhl1976"
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