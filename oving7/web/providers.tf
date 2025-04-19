terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "rg-be-tfstate-jhl1"
      storage_account_name = "sabejhl1976"
      container_name       = "scbejhl1"
      #key                  = "web-jhl.terraform.tfstate" #ikke overskrive eksiterende backend tfstate
      key = "terraform-${var.workspace_name}.tfstate"     #kan ikke benytte output, locals, terraform.workspace i en backend blokk, da backend er allered konfigurert
    }
  }

provider "azurerm" {
  features {}
}