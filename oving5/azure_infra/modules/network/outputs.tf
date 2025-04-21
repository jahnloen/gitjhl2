output "subnet_id" { #skal benyttes av main.tf i rotmodul
  value       = azurerm_subnet.subnet.id
  description = "subnet id value"
}

output "public_ip_id" {
  value = azurerm_public_ip.public_ip.id
  description = "Public IP ID value"
}

