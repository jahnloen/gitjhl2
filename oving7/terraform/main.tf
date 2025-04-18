resource "azurerm_resource_group" "rgname" {
  name = var.rg_name
  location = var.rg_location
}