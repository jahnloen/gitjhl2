resource "azurerm_mssql_server" "mssqlserver" {
  name                         = var.mssqlname
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.mssql_username
  administrator_login_password = azurerm_key_vault_secret.mssql_password.value
  #tags = var.common_tags
}

resource "azurerm_mssql_database" "mssqldb" {
  name           = var.mssqldbname
  server_id      = azurerm_mssql_server.mssqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "S0"
  zone_redundant = false
  #tags = var.common_tags

  lifecycle {
    prevent_destroy = false
  }
}