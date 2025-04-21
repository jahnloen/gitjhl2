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
  name = var.resource_group_name
  #count    = length(var.resource_group_names)      #antall ressursgruppper som  lages basert på variablen
  #name     = var.resource_group_names[count.index] #gir unikt navn basert på variablen
  #count    = length(local.resource_group_names)
  #resource_group_name = azurerm_resource_group.rg.name
  location = var.location      #required
  tags     = local.common_tags #definerte tags i locals.tf
}

resource "azurerm_resource_group" "networkjhl" {
  name     = "networkjhl"
  location = var.location
  tags     = local.common_tags
}

#resource "azurerm_resource_group" "vm" {
#  name     = "virtual_machines"
#  location = var.location
#  tags                = local.common_tags

#}

#Count brukes for å skape flere eksemplarer av ressurser eller moduler. Antall kan gis via default verdier eller input
resource "azurerm_storage_account" "sa" {                           #ressurs for SA
  count                    = length(var.storage_account_names)      #ant.storage accounts som  lages basert på variabel og terraform.tfvars
  name                     = var.storage_account_names[count.index] #globalt unikt, kun småbokst og tall
  resource_group_name      = azurerm_resource_group.rg.name         #navn fra TF resource over
  location                 = var.location                           #tatt fra location over
  account_tier             = var.account_tier                       #hastighet på lagring
  account_replication_type = var.account_replication_type           #redundansnivå
  tags                     = local.common_tags
}

resource "azurerm_network_security_group" "nsgjhl1" { #gjenbruker ressursgruppa rg_name, og lager ikke egen denne gang
  name                = var.network_security_group1
  location            = var.location
  resource_group_name = azurerm_resource_group.networkjhl.name
  tags                = local.common_tags
}

resource "azurerm_network_security_group" "nsgjhl2" { #gjenbruker ressursgruppa rg_name, og lager ikke egen denne gang
  name = var.network_security_group2
  #location           = azurerm_resource_group.rgname.location
  location            = var.location
  resource_group_name = azurerm_resource_group.networkjhl.name
  tags                = local.common_tags
}

resource "azurerm_virtual_network" "vnetjhl1" {
  name                = var.virtual_network1
  location            = var.location
  resource_group_name = azurerm_resource_group.networkjhl.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = local.common_tags

  subnet {
    name             = var.subnet1
    address_prefixes = ["10.0.1.0/24"] #256 IPer
    security_group   = azurerm_network_security_group.nsgjhl1.id
  }

  subnet {
    name             = var.subnet2
    address_prefixes = ["10.0.2.0/24"] #256 IPer
    security_group   = azurerm_network_security_group.nsgjhl1.id
  }
}

resource "azurerm_virtual_network" "vnetjhl2" { #ressurs for virtuelt nettverks
  name                = var.virtual_network2
  location            = var.location
  resource_group_name = azurerm_resource_group.networkjhl.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = local.common_tags

  #resource "azurerm_subnet" "subnetjhl1" { #ressurs for virtuelt nettverks
  #  virtual_network_name = "vnetjhl2"
  #  name                 = "subnetjhl1"
  #  #location            = var.location
  #  resource_group_name = azurerm_resource_group.networkjhl.name
  #  #address_space       = var.address_space
  #  address_prefixes = ["10.0.3.0/24"] #256 IPer
  #security_group   = azurerm_network_security_group.nsgname1.id
  #tags = local.common_tags

  subnet {
    name             = var.subnet3
    address_prefixes = ["10.0.3.0/24"] #256 IPer
    security_group   = azurerm_network_security_group.nsgjhl2.id
  }

  subnet {
    name             = var.subnet4
    address_prefixes = ["10.0.4.0/24"] #256 IPer
    security_group   = azurerm_network_security_group.nsgjhl2.id
  }
}

#resource "azurerm_network_interface" "nic" {
#  name                = "Linux-nic"
#  location            = var.location
#  resource_group_name = azurerm_resource_group.network.name
#  tags                = local.common_tags


#  ip_configuration {
#    name                          = "internal"
#    subnet_id                     = azurerm_subnet.subnet1.id
#    private_ip_address_allocation = "Dynamic"
#
#  }
#}

#resource "azurerm_linux_virtual_machine" "linvm" { #ressursgruppe Linux VM
#  name                = "Linux_VM-${var.environment}"
#  location            = var.location
#  resource_group_name = azurerm_resource_group.vm.name
#  size                = var.vm_size[var.environment]
#  #size = local.vm_size
#  admin_username        = "adminuser"
#  #admin_password        = "Password1234!"
#  network_interface_ids = [azurerm_network_interface.nic.id]
#  tags                = local.common_tags


#os_disk {
#  caching              = "ReadWrite"
#  storage_account_type = "Standard_LRS"
#}

#source_image_reference {
#  publisher = "Canonical"
#  offer     = "UbuntuServer"
#  sku       = "18.04-LTS"
#  version   = "latest"
# }


#}

#tags = {
#  environment = var.environment #f.eks. test, staging eller prod
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

