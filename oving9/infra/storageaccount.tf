resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.saname)}${random_string.random_string.result}" #vilkårlig navn på sa
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  min_tls_version          = "TLS1_2" #removes support for TLS1.0 and 1.1
  account_tier             = "Standard"
  account_replication_type = "LRS" #local redundant storage
}

resource "azurerm_storage_container" "sc" {
  name = "${var.scname}${var.basename}"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

resource "azurerm_storage_account_static_website" "sta_web" {
  storage_account_id = azurerm_storage_account.sa.id #Azure ID for sa ressurs (sa)
  index_document     = var.index_document
}

resource "azurerm_storage_blob" "index_html" { #avhengig av sa og static website container $web
  name                 = var.index_document
  storage_account_name = azurerm_storage_account.sa.name
  storage_container_name = "$web" #spesiell reservert kontainer for statiske web hosting
  type                   = "Block"
  content_type           = "text/html"
  source_content = "${var.source_content}}"

  depends_on = [
    azurerm_storage_account_static_website.sta_web #"azurerm_storage_account_static_website" ressursen skal ferdigstilles, før blob lastes opp  
  ]
}

#terraform workspace list - lister alle workspaces som er tilgjengeligte
#terraform workspace new prod/test/dev - nye workspace for å separere miljø
#terraform workspace select test
#destroy
#https://aquasecurity.github.io/tfsec/v1.28.1/checks/azure/storage/use-secure-tls-policy/