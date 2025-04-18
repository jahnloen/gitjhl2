resource "random_string" "random_string" {  #til bruk for navn på sa
    length = 8
    special = false
    upper = false 
}

resource "azurerm_resource_group" "rg_web" {
    name = var.rg_name
    location = var.location
}

resource "azurerm_storage_account" "sa_web" {
  name = "${var.sa_name}${random_string.random_string.result}" #vilkårlig navn på sa
  resource_group_name = azurerm_resource_group.rg_web.name
  location = azurerm_resource_group.rg_web.location
  account_tier = "Standard"
  account_replication_type = "LRS" #local redundant storage
}

  resource "azurerm_storage_account_static_website" "sta_web" {
    storage_account_id = azurerm_storage_account.sa_web.id  #Azure ID for sa ressurs (her er det sa_web)
    index_document = var.index_document
  }

resource "azurerm_storage_blob" "index_html" {
    name = var.index_document
    storage_account_name = azurerm_storage_account.sa_web.name
    storage_container_name = "$web" #spesiell reservert kontainer for statiske web hosting
    type = "Block"
    content_type = "text/html"
    source_content = var.source_content #innhold
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint  #output er fra index.html
}