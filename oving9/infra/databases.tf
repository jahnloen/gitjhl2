resource "azurerm_mssql_server" "mssqlserver" {
  name                = "${var.mssqlsrv_name}-${var.basename}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "12.0"
  administrator_login          = "${var.mssql_admin}-${var.basename}"
  administrator_login_password = azurerm_key_vault_secret.mssql_admin_password.value
  #tags = var.common_tags
}

resource "azurerm_mssql_database" "mssqldb" {
  name           = "${var.mssqldb_name}-${var.basename}"
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