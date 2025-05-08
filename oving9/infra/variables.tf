#general variables
variable "basename" {
  type = string
  description = "environment or projectname"
  default = "jhl"
}

variable "location" {
  type        = string
  description = "location of resources"
  default     = "westeurope"
}

variable "rgname" {
  type        = string
  description = "name of rg"
  default     = "rgjhl1"
}

#varables for keyvault
variable "kvname" {
  type = string
}

variable "sa_accesskey_name" {
  type = string
}

#varables for web
variable "source_content" {
  type = string
  description = "content of index.html "
  default = "<h1>Made with Terraform - Update del1</h1>"
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
  default     = "sajhl0"
}

variable "scname" {
  type = string
  description = "name of storage container"
  default = "scname"
  
}

#variabler for database

variable "mssqlname" {
  type        = string
  description = "mssql server name"
  default     = "mssqlsrv-jhl-0"
}

variable "mssqldbname" {
  type        = string
  description = "mssql database name"
  default     = "mssqldb-jhl-0"
}

#variabler for vm
variable "vmname" {
  type        = string
  description = "vm name"
  default     = "vm-jhl-0"
}

variable "vm_username" {
  type = string
  description = "Admin Username VM"
  default = "adminjhl"  
}

#variabler for vmss
variable "vmssname" {
  type        = string
  description = "vmss name"
  default     = "vmss-jhl-0"
}

#variable "vmssinstances" {
#  type        = number
#  description = "number of vmss instances"
#  default     = 0
#}

variable "subnet_id" {
  description = "subnet id"
  type        = string
  default     = "" #dette betyr blank/tom verdi
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
  default     = "pubip-jhl-1"
}

variable "public_ip_id" {
  description = "Public IP name"
  type        = string
  default     = ""
}


variable "domain_name_label" {
  description = "name of domain"
  type        = string
  default     = "jhl-domain-0"
}


