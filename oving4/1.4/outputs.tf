#egen fil for outputs
#kan brukes til å vise verdier for variabler og beregninger når "terraform apply" er kjørt

output "virtual_network1" {
  description = "name of created virtual networks"
  value       = var.virtual_network1
}

output "virtual_network2" {
  description = "name of created virtual networks"
  value       = var.virtual_network2
}

output "subnet1" {
  description = "name of created subnets"
  value       = var.subnet1
}

output "subnet2" {
  description = "name of created subnets"
  value       = var.subnet2
}

output "subnet3" {
  description = "name of created subnets"
  value       = var.subnet3
}

output "subnet4" {
  description = "name of created subnets"
  value       = var.subnet4
}

output "linvm_count" {
  description = "number of created VMs"
  value       = var.linvm_count
}

output "linvm_name" {
  description = "name of created VMs"
  value       = [for i in range(var.linvm_count) : "linvm-${var.environment}-${i + 1}"]
}

output "os_disk_names" {
  description = "name of created VMs"
  value       = [for i in range(var.linvm_count) : "osdisk-${var.environment}-${i + 1}"]
}

output "computer_name" {
  description = "host name of created VMs"
  value       = [for i in range(var.linvm_count) : "linvm-${var.environment}-${i + 1}"]
}