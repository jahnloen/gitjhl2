
resource "azurerm_key_vault" "kv" {
  name                        = "kv-${lower(var.kvname)}${random_string.random_string.result}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]

    storage_permissions = [
      "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_accesskey" {
  name         = var.sa_accesskey_name
  value        = azurerm_storage_account.sa.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_storage_account.sa
  ]
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "${var.vmname}${random_string.random_string.result}"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    random_password.password
  ]
}

#sjekk om tfstate filer blir laget:
#az storage blob list --container-name "sett inn ditt container navn" --account-name "sitt SA navn" --output table