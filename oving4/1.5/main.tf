#main.tf brukes for å definere kjerneverdier i infrastrukturen, og for å kalle andre moduler
#koden finnes på https://registry.terraform.io/


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
  }
}
provider "azurerm" {
  # Configuration options
  subscription_id = var.subscription_id #må med etter v4.0
  features {                            #required
  }
}

#regel: en ressursblokk definerer ett infrastrukturobjekt
resource "azurerm_resource_group" "rg" {
  name     = local.common_resource_group_name
  location = local.common_location
  tags = local.common_tags #definerte tags i locals.tf
}

#Count brukes for å skape flere eksemplarer av ressurser eller moduler. Antall kan gis via default verdier eller input
resource "azurerm_storage_account" "sa" { #ressurs for SA
  count = var.storage_account_count
  #name     = "sajhl${var.environment}${count.index + 1}"
  name                     = "${local.storage_account_name}${count.index + 1}"
  resource_group_name      = azurerm_resource_group.rg.name #navn fra TF resource over
  location                 = var.location                   #tatt fra location over
  account_tier             = var.account_tier               #hastighet på lagring
  account_replication_type = var.account_replication_type   #redundansnivå
  tags                     = local.common_tags
}

resource "azurerm_resource_group" "networkrg" { #egen ressursgruppe for nettverk
  count    = var.networkrg_count
  name     = "${local.networkrg_name}${count.index + 1}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.network_security_group1
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags
}

resource "azurerm_network_security_group" "nsg2" {
  name                = var.network_security_group2
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.virtual_network1
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = local.common_tags
}

resource "azurerm_virtual_network" "vnet2" { #ressurs for virtuelt nettverks
  name                = var.virtual_network2
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = local.common_tags
}

resource "azurerm_subnet" "subnetjhl1" { #ressurs for virtuelt nettverks
  name                 = var.subnet1
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"] #256 IPer
}

resource "azurerm_subnet" "subnetjhl2" { #ressurs for virtuelt nettverks
  name                 = var.subnet2
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"] #256 IPer
}

resource "azurerm_subnet" "subnetjhl3" { #ressurs for virtuelt nettverks
  name                 = var.subnet3
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.0.3.0/24"] #256 IPer
}

resource "azurerm_subnet" "subnetjhl4" { #ressurs for virtuelt nettverks
  name                 = var.subnet4
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.0.4.0/24"] #256 IPer
}

#ressursblokk for å koble NSG og subnet
resource "azurerm_subnet_network_security_group_association" "subnetandsg1" {
  subnet_id                 = azurerm_subnet.subnetjhl1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "subnetandsg2" {
  subnet_id                 = azurerm_subnet.subnetjhl2.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "subnetandsg3" {
  subnet_id                 = azurerm_subnet.subnetjhl3.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}

resource "azurerm_subnet_network_security_group_association" "subnetandsg4" {
  subnet_id                 = azurerm_subnet.subnetjhl4.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}

resource "azurerm_network_interface" "nicjhl1" {
  name                = "nicjhl1-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetjhl1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linvm" {      #ressursgruppe Linux VM
  count = var.linvm_count                               #variabel som er grunnlag for antall Linux VM
  name  = "linvm-${var.environment}-${count.index + 1}" #navn+miljø+teller fra 0
  #name = som sett fra Azure portal
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nicjhl1.id]
  size                  = var.vm_sizes[var.environment]
  tags                  = local.common_tags

  os_disk {
    name    = "osdisk-${var.environment}-${count.index + 1}"
    caching = "ReadWrite"
    #create_option        = "FromImage"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  computer_name  = "linvm-${var.environment}-${count.index + 1}" #hostname,som sett fra VM
  admin_password = "Password1234!"

  #os_profile_linux_config {
  disable_password_authentication = false
}


#tags = {
#environment = var.environment #f.eks. test, staging eller prod
#}




#iput variables: globalt tilgjengelig i en modul, krever egen variable blokk, kan bekrense input til bestemt type, 
#settes ved modulkall, kommandolinje eller i .tfvars
#local values: defines i egen locals blokk, begrenset til nåværende modul (ikke global), kan ikke endres utenfor modulen, 
#kan inneholde komplekse utrykk og andre verdier
#locals er lokale verdier som fungerer som midlertidig variabler
#interne beregninger basert på input variables eller andre ressurser
#forenkle lesbarhet ved å gi navn til ofte brukte ressurser

#før kjøring
#sjekk locals før kjøring terraform console > linjeshift local.common_tags
#liste ut verdiene i en "count variabel" ved terraform console > linjeshift > var.storage.account.names[0]
#vil da liste ut første output verdi i variablen og [1] er da andre verdi

#kjøring:
#gå til målmappe i PowerShell, kjør "terraform init", i mappa opprettes filene .terraform og .terraform-lock-hcl
#etterpå må det logges på AZ (Connect-Azure.azcli)
#terraform validate (sjekker syntax og konsistens i kode, samt kommer med forslag)
#terraform fmt (standardisering og kosistens i kode i konfigurasjonsfiler )
#terraform plan (viser endringer som vil bli utført)
#terraform plan -out main.tfplan (lager ei fil som viser endringene, gir sikkerhet 
#og benyttes i CICD for å sikre at rette endringer blir gjort, husk versjonering av fil)
#terraform show main.tfplan (print av endringene i fila -> revider)
#terraform apply "main.tfplan" reviderete endringer kjøres ved hjelp av en main.tfplan fil
#terraform apply (implementerer endringer uten main.tfplan, dvs. ikke revidering

