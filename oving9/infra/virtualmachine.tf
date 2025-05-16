resource "azurerm_network_interface" "vmnic" { #ressurs flyttes til denne modulen, så variabel ikke trengs å sendes
  name                = "jhl-nic-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id #verdi som skal sendes fra nettverk
  }
}

resource "azurerm_windows_virtual_machine" "winvm" {
  name                = "${var.winvm_name}-${var.basename}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  #size                 = "Standard_F2"
  size                  = var.winvm_size
  admin_username        = var.winvm_username
  admin_password        = azurerm_key_vault_secret.winvm_password.value
  network_interface_ids = [azurerm_network_interface.vmnic.id] #ikke variabel, da "vmnic" ressursen er i samme modul
  #tags                  = var.common_tags

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}


resource "azurerm_linux_virtual_machine" "linvm" {
  name                = "${var.linvm_name}-${var.basename}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.winvm_size
  #size                            = "Standard_B1ms"
  admin_username                  = var.linvm_username
  admin_password                  = azurerm_key_vault_secret.linvm_password.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.vmnic.id]

  #depends_on = [azurerm_network_interface.vmnic]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

#output "vmmic_id" {
#  value = azurerm_windows_virtual_machine.vmnic.id
#}

