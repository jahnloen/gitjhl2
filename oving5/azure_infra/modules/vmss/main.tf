resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                 = var.vmssname
  resource_group_name  = var.rgname
  location             = var.location
  sku                  = "Standard_B1s"
  #instances            = 2
  instances = var.vmssinstances
  admin_password       = "P@55w0rd1234!"
  admin_username       = "jhladminuser"
  computer_name_prefix = "vmss-"
  tags = var.common_tags

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

  network_interface {
    name    = "nic-jhl0"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }
}