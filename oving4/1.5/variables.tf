#variabelfil for å deklarere variabler og default verdier
#lastes automatisk om i samme mappe som andre TF filene i prosjektet
#locals fungerer som midlertidig variabler
#default verdi kan ikke settes ved å benytte verdien fra en annen variabel, da må locals benyttes istedet


#input variables

variable "environment" {
  type        = string
  description = "type miljø dev, test og prod"
  default     = "dev"
}

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

variable "storage_account_count" {
  description = "The number of storage accounts to create"
  type        = number
  default     = 1
}

variable "storage_account_name" {
  type = list(string)
  description = "Values for Storage Account Name"
  default     = ["sajhl00"] #list string verdi
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

variable "subscription_id" {
  type        = string
  description = "abonnements id"
}

variable "networkrg_count" {
  description = "Number of Virtual Networks to create"
  type        = number
  default     = 1 #om default fjernes så jeg man taste inn antall
}

variable "networkrg_name" {
  description = "Number of Virtual Networks to create"
  type        = list(string)
  default     = ["networkrg"] #list string verdi
}

variable "network_security_group1" {
  type        = string
  description = "network security group"
}

variable "network_security_group2" {
  type        = string
  description = "network security group"
}

variable "virtual_network_count" {
  type        = number
  default     = 1
  description = "number of virtual networks"
}

variable "virtual_network1" {
  type        = string
  description = "virtual network"
}

variable "virtual_network2" {
  type        = string
  description = "virtual network"
}

variable "vm_sizes" {
  type        = map(string)
  description = "Størrelse Virtuell Maskin"
  default = {
    "dev"  = "Standard_B2s"
    "test" = "Standard_B2ms"
    "prod" = "Standard_DS2_v2"
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "dns servers"
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

variable "linvm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1 #om default fjernes så jeg man taste inn antall
}
