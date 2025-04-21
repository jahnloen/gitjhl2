variable "rgname" {
  type        = string
  description = "resource group name"
  default     = "rg-jhl-0"
}

#slik at rotmodulen kan sende infoen til modulene som ikke har dette selv (her er det da db og vmss)

#variabler for nettverksmodul
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

#variabler for database modul
variable "saname" {
  type        = string
  description = "storage account name"
  default     = "sajhl0"
}

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

#variabler for vm modul
variable "vmname" {
  type        = string
  description = "vm name"
  default     = "vm-jhl-0"
}

#variabler for vmss modul
variable "vmssname" {
  type        = string
  description = "vmss name"
  default     = "vmss-jhl-0"
}

variable "vmssinstances" {
  type        = number
  description = "number of vmss instances"
  default     = 0
}

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

#variabler som sendes til tags
variable "location" {
  type    = string
  default = "West Europe"
}

variable "environment" {
  type        = string
  description = "type miljø dev, test og prod"
  default     = "dev"
}

variable "company" {
  type        = string
  description = "bedriftsnavn"
  default     = "JHL-IT-0"
}

variable "cost_center" {
  type        = string
  description = "faktureringavdeling"
  default     = "IT-0"
}

variable "owner" {
  type        = string
  description = "prosjekteier"
  default     = "JHL"
}

variable "project" {
  type        = string
  description = "prosjektnavn"
  default     = "TF-100"
}

variable "billing_code" {
  type        = string
  description = "Billing Code"
  default     = "ID19760"
}