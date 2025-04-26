output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint #output er fra index.html
}