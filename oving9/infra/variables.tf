#general variables
variable "basename" {
  type        = string
  description = "environment or projectname"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "location of resources"
  default     = "westeurope"
}

variable "rgname" {
  type        = string
  description = "name of rg"
  default     = "rgjhl0"
}

#varables for keyvault
variable "kvname" {
  type    = string
  default = "kv0"
}

variable "sa_accesskey_name" {
  type    = string
  default = "sa-accesskey-0"
}

#varables for web
variable "source_content" {
  type        = string
  description = "content of index.html "
  default     = "<h1>Made with Terraform - Hello0</h1>"
}

variable "index_document" {
  type        = string
  description = "name of index content"
  default     = "index.html"
}

#variabler for nettverk
variable "nsgname" {
  type    = string
  default = "nsg-jhl-0"
}

variable "vnetname" {
  type    = string
  default = "vnet-jhl-0"
}

variable "subnetname" {
  type        = string
  description = "subnet name"
  default     = "sub-jhl-0"
}

#variables for storage account

variable "saname" {
  type        = string
  description = "storage account name"
  default     = "sa"
}

variable "scname" {
  type        = string
  description = "name of storage container"
  default     = "scjhl0"

}

#variabler for database

variable "mssqlsrv_name" {
  type        = string
  description = "mssql server name"
  default     = "mssqlsrv-jhl-0"
}

variable "mssqldb_name" {
  type        = string
  description = "mssql database name"
  default     = "mssqldb-jhl-0"
}

variable "mssql_admin" {
  type        = string
  description = "msql login name"
  default     = "mssqladminjhl0"

}

#variabler for vm
variable "winvm_name" {
  type        = string
  description = "vm name for Windows"
  default     = "winvm-jhl-0"
}

variable "winvm_username" {
  type        = string
  description = "Admin Username Windows VMs"
  default     = "winadminjhl0"
}

variable "linvm_name" {
  type        = string
  description = "vm name for Linux"
  default     = "linvm-jhl-0"
}

variable "linvm_username" {
  type        = string
  description = "Admin Username Linux VMs"
  default     = "linadminjhl1"
}

variable "winvm_size" {
  type        = string
  description = "SKU model for Windows servers"
  default     = "Standard_B1ms"
}

variable "linvm_size" {
  type        = string
  description = "SKU model for Linux servers"
  default     = "Standard_B1ms"
}

#variabler for vmss
#variable "vmssname" {
#  type        = string
#  description = "vmss name"
#  default     = "vmss-jhl-0"
#}

#variable "vmssinstances" {
#  type        = number
#  description = "number of vmss instances"
#  default     = 0
#}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
  default     = "pubip-jhl-0"
}

variable "domain_name_label" {
  description = "name of domain"
  type        = string
  default     = "jhl-domain-0"
}

variable "ssh_public_key" {
  description = "SSH pubkey for linvm"
  type        = string
  #default = "" #dynamic for local CLI run, supplements GITHUB action
}


