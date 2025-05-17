#locals {
#workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}" #om workspace ikke er default, skal navneendelse tilsvare navnet på nåværende workspace

#rgname    = terraform.workspace == "default" ? "${var.rgname}" : "${var.rgname}-${local.workspace_suffix}"
#web_suffix = "<h1>${terraform.workspace}</h1>"
#peker på egne filer basert på aktivt workspace. Delt inn i undermapper med hver sin index.html, men tilsvarende skrift. Kunne brukt template her
#}



resource "azurerm_resource_group" "rg" {
  name     = "${var.rgname}-${var.basename}"
  location = var.location
}

resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!%&*()-_=+[]{}<>:?"
}

output "winvm_password" {
  #value     = azurerm_key_vault_secret.vm_password.value
  value     = azurerm_key_vault_secret.winvm_password.value
  sensitive = true
}

output "linvm_password" {
  value     = azurerm_key_vault_secret.linvm_password.value
  sensitive = true
}