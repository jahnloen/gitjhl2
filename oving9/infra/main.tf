locals {
  #workspace_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}" #om workspace ikke er default, skal navneendelse tilsvare navnet på nåværende workspace

  #rgname    = terraform.workspace == "default" ? "${var.rgname}" : "${var.rgname}-${local.workspace_suffix}"
  #web_suffix = "<h1>${terraform.workspace}</h1>"
  #peker på egne filer basert på aktivt workspace. Delt inn i undermapper med hver sin index.html, men tilsvarende skrift. Kunne brukt template her
}


resource "azurerm_resource_group" "rg" {
  name     = var.rgname
  location = var.location
}