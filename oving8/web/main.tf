locals {
  workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}" #om workspace ikke er default, skal navneendelse tilsvare navnet på nåværende workspace

  rg_web    = terraform.workspace == "default" ? "${var.rg_web}" : "${var.rg_web}-${local.workspace_suffix}"
  sa_web    = terraform.workspace == "default" ? "${var.sa_web}" : "${var.sa_web}${local.workspace_suffix}"
  #source_file = terraform.workspace == "default" ? "${path.module}/../web/index.html" : "${path.module}/../web/${terraform.workspace}/index.html"
  web_suffix = "<h1>${terraform.workspace}</h1>"
  #peker på egne filer basert på aktivt workspace. Delt inn i undermapper med hver sin index.html, men tilsvarende skrift. Kunne brukt template her
}


resource "random_string" "random_string" { #til bruk for navn på sa
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg_web" {
  name     = local.rg_web
  location = var.location
}

resource "azurerm_storage_account" "sa_web" {
  name                     = "${lower(local.sa_web)}${random_string.random_string.result}" #vilkårlig navn på sa
  resource_group_name      = azurerm_resource_group.rg_web.name
  location                 = azurerm_resource_group.rg_web.location
  account_tier             = "Standard"
  account_replication_type = "GRS" #local redundant storage
}

resource "azurerm_storage_account_static_website" "sta_web" {
  storage_account_id = azurerm_storage_account.sa_web.id #Azure ID for sa ressurs (sa_web)
  index_document     = var.index_document
  #index_document = "index.html"
}

resource "azurerm_storage_blob" "index_html" { #avhengig av sa og static website container $web
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.sa_web.name
  storage_container_name = "$web" #spesiell reservert kontainer for statiske web hosting
  type                   = "Block"
  content_type           = "text/html"
  #source                 = local.source_file #kan ikke ha både source og source content
  source_content         = "${var.source_content}${local.web_suffix}"

  depends_on = [
    azurerm_storage_account_static_website.sta_web #"azurerm_storage_account_static_website" ressursen skal ferdigstilles, før blob lastes opp  
  ]
}

#terraform workspace list - lister alle workspaces som er tilgjengeligte
#terraform workspace new prod/test/dev - nye workspace for å separere miljø
#terraform workspace select dev
#dest