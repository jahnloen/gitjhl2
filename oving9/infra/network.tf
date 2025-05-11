resource "azurerm_network_security_group" "nsg" {
  #name                = var.nsgname
  name                = "${var.nsgname}-${var.basename}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #tags                = var.common_tags
}

resource "azurerm_network_security_rule" "nsgrule" {
  name                        = "RDP_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  #destination_port_range      = "3389"
  destination_port_ranges     = ["22", "80", "3389"]
  source_address_prefix       = "89.10.131.77"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


#resource "azurerm_network_security_rule" "nsgrulelin" {
#  name = "SSH_access"
#  priority = 100
#  direction = "Inbound"
#  access = "Allow"
#  protocol = "Tcp"
#  source_port_range = "*"
#  destination_port_range = "22"
#  destination_address_prefix  = "*"
#  resource_group_name         = azurerm_resource_group.rg.name
#  network_security_group_name = azurerm_network_security_group.nsg.name
#}


resource "azurerm_virtual_network" "vnet" {
  #name                = var.vnetname
  name                = "${var.vnetname}-${var.basename}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  #tags                = var.common_tags #mottar verdi fra rot
}

resource "azurerm_public_ip" "public_ip" {
  #name                = var.public_ip_name
  name                = "${var.public_ip_name}-${var.basename}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = var.domain_name_label
  #tags                = var.common_tags
}

resource "azurerm_subnet" "subnet" {
  #name                 = var.subnetname
  name                 = "${var.subnetname}-${var.basename}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" { #kobler sub + nsg id
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  #verdien av disse finnes i outputs.tf i denne modulen
}

output "subnet_id" { #skal benyttes av main.tf i rotmodul
  value       = azurerm_subnet.subnet.id
  description = "subnet id value"
}

output "public_ip_id" {
  value       = azurerm_public_ip.public_ip.id
  description = "Public IP ID value"
}