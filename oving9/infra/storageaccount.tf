




resource "random_string" "random_string" { #til bruk for navn på sa
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "sa_web" {
  name                     = "${lower(local.sa_web)}${random_string.random_string.result}" #vilkårlig navn på sa
  resource_group_name      = azurerm_resource_group.rg_web.name
  location                 = azurerm_resource_group.rg_web.location
  account_tier             = "Standard"
  account_replication_type = "LRS" #local redundant storage
}