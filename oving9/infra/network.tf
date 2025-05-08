#resource "azurerm_resource_group" "rg" {
#  name     = var.rgname
#  location = var.location
  #tags     = local.common_tags #bruker locals.tf fila i rotmodulen
  #tags i locals.tf er her variabler, sendes de til undermodulene
#}

#defineres her for å kunne sende input til modulene, som ikke har disse
#module "network" {
  #source            = "./modules/network"
  #rgname            = azurerm_resource_group.rg.name
  #location          = var.location
  #vnetname          = var.vnetname   #for å kunne overføres til moduler som ikke har denne resursen
  #nsgname           = var.nsgname    #for å kunne overføres til moduler som ikke har denne resursen
  #subnetname        = var.subnetname #for å kunne overføres til moduler som ikke har denne resursen
  #domain_name_label = var.domain_name_label
  #public_ip_name    = var.public_ip_name
  #common_tags       = local.common_tags
#}

#module "vmss" {
#  source    = "./modules/vmss"
#  rgname    = azurerm_resource_group.rg.name
#  location  = var.location
#  vmssname  = var.vmssname
#  subnet_id = module.network.subnet_id #peker på network modulen og verdi fra outputs.tf, 
  #og sendes til vmss modulen slik at subnet kan brukes
#  common_tags = local.common_tags
#}

module "virtual_machines" {
  source    = "./modules/virtual_machines"
  rgname    = azurerm_resource_group.rg.name
  location  = var.location
  vmname    = var.vmname
  subnet_id = module.network.subnet_id #peker på network modulen og verdi fra outputs.tf, 
  #og sendes til vm modulen slik at subnet kan brukes
  public_ip_id = module.network.public_ip_id
  common_tags  = local.common_tags
}

#module "databases" {
#  source      = "./modules/databases" #filstruktur og mappe for modul
#  rgname      = azurerm_resource_group.rg.name
#  location    = var.location
#  saname      = var.saname
#  mssqlname   = var.mssqldbname
#  mssqldbname = var.mssqldbname
#  common_tags = local.common_tags
#}

output "subnet_id" { #skal benyttes av main.tf i rotmodul
  value       = azurerm_subnet.subnet.id
  description = "subnet id value"
}

output "public_ip_id" {
  value = azurerm_public_ip.public_ip.id
  description = "Public IP ID value"
}