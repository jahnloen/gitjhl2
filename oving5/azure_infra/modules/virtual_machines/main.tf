resource "azurerm_network_interface" "vmnic" { #ressurs flyttes til denne modulen, så variabel ikke trengs å sendes
  name                = "jhl-nic-1"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id  #verdi som skal sendes fra nettverksmodulen
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vmname
  resource_group_name   = var.rgname
  location              = var.location
  size                  = "Standard_B1s"
  admin_password        = "P@55w0rd1234!"
  admin_username        = "jhladminuser"
  network_interface_ids = [azurerm_network_interface.vmnic.id] #ikke variabel, da "vmnic" ressursen er i samme modul
  tags                  = var.common_tags

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