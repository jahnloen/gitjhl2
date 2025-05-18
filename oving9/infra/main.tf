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
  value     = azurerm_key_vault_secret.winvm_password.value
  sensitive = true
}

output "linvm_password" {
  value     = azurerm_key_vault_secret.linvm_password.value
  sensitive = true
}