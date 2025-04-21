#variabelfil for å deklarere variabler og default verdier
#lastes automatisk om i samme mappe som andre TF filene i prosjektet
#locals fungerer som midlertidig variabler



#input variables

variable "company" {
  type        = string
  description = "bedriftsnavn"
  default     = "JHLIT"
}

variable "cost_center" {
  type        = string
  description = "faktureringavdeling"
}

variable "owner" {
  type        = string
  description = "prosjekteier"
  default     = "JHL"
}

variable "number_of_storage_accounts" {
  description = "The number of storage accounts to create"
  type        = number
  default     = 3
}

variable "storage_account_names" {
  type        = list(string)
  description = "Values for Storage Account Name"
  #default     = ["jhl00"]  #list string verdi
}

variable "project" {
  type        = string
  description = "prosjektnavn"
}

variable "billing_code" {
  type        = string
  description = "Billing Code"
}

variable "location" {
  type        = string
  description = "deployment location"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Values fo Resource Group Name"
  default     = "rg-jhl00"
}

variable "account_tier" {
  type        = string
  description = "hastighet på lagring"
}

variable "account_replication_type" {
  type        = string
  description = "redundansnivå lagring"
}

variable "environment" {
  type        = string
  description = "type miljø"
  default     = "dev"
}

variable "subscription_id" {
  type        = string
  description = "abonnements id"
}

variable "network_security_group1" {
  type        = string
  description = "network security group"
}

variable "network_security_group2" {
  type        = string
  description = "network security group"
}

variable "virtual_network1" {
  type        = string
  description = "virtual network"
}

variable "virtual_network2" {
  type        = string
  description = "virtual network"
}

variable "vm_size" {
  type        = map(string)
  description = "Størrelse Virtuell Maskin"
  default = {
    "dev"  = "Standard_B1s"
    "test" = "Standard_B2s"
    "prod" = "Standard_B3S"
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "iprange"
}

variable "address_space" {
  type        = list(string)
  description = "iprange"
}


variable "subnet1" {
  type        = string
  description = "subnet name"
}

variable "subnet2" {
  type        = string
  description = "subnet name"
}

variable "subnet3" {
  type        = string
  description = "subnet name"
}

variable "subnet4" {
  type        = string
  description = "subnet name"
}


#locals