locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}" #om workspace ikke er default, skal navneendelse tilsvare navnet på nåværende workspace

  rg_name = "${var.rg_name}-${local.workspaces_suffix}" #legger til feks dev bak navnet på rg
  #rg_web_name = "${var.rg_web_name}-${local.workspaces_suffix}" #legger til feks dev bak navnet på rg
}

resource "azurerm_resource_group" "rg" {
  name = local.rg_name
  location = var.location
}

#resource "azurerm_resource_group" "rg_web" {
#    name = var.rg_web_name
#    location = var.location
#}

#output "rg_name" {
#  value = azurerm_resource_group.rg.name
#}

#terraform workspace list - lister alle workspaces som er tilgjengeligte
#terraform workspace new prod/test/dev - nye workspace for å separere miljø
#terraform workspace select dev
#terraform init -reconfigure
#terraform init -migrate-state