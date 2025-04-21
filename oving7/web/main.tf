locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}" #om workspace ikke er default, skal navneendelse tilsvare navnet på nåværende workspace

  rg_web = "${var.rg_web}-${local.workspaces_suffix}" #legger til feks dev bak navnet på rg
  source_file = terraform.workspace == "default" ? "${path.module}/../web/index.html" : "${path.module}/../web/${terraform.workspace}/index.html" #peker på egne filer basert på aktivt workspace
}


resource "random_string" "random_string" {  #til bruk for navn på sa
    length = 8
    special = false
    upper = false 
}

resource "azurerm_resource_group" "rg_web" {
    name = var.rg_web
    location = var.location
}

resource "azurerm_storage_account" "sa_web" {
  name = "${var.sa_web}${random_string.random_string.result}" #vilkårlig navn på sa
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
    #name = "index.html"
    storage_account_name = azurerm_storage_account.sa_web.name
    storage_container_name = "$web" #spesiell reservert kontainer for statiske web hosting
    type = "Block"
    content_type = "text/html"
    source = local.source_file #kan ikke ha både source og source content
    #source_content = var.source_content #innhold
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint  #output er fra index.html
}

#terraform workspace list - lister alle workspaces som er tilgjengeligte
#terraform workspace new prod/test/dev - nye workspace for å separere miljø
#terraform workspace select dev