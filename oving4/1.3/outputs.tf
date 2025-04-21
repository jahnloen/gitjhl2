#egen fil for outputs
#kan brukes til å vise verdier for variabler og beregninger når "terraform apply" er kjørt

output "storage_account_names" {
  description = "name of created storage accounts"
  value       = var.storage_account_names
}