output "remote_key_vault_id" {
  value = data.terraform_remote_state.bejhl1.outputs.kv_backend.id
}