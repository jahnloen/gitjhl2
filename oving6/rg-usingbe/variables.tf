#lastes automatisk om i samme mappe som andre TF filene i prosjektet

variable "location" {
  type        = string
  description = "deployment location"
}

variable "rg-name" {
  type        = string
  description = "Resource Group Name"
}

variable "saname" {
  type        = string
  description = "Storage Account Name"
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
}

#variable "subscription_id" {
#  type        = string
#  description = "abonnements id"
#}

variable "nsgname" {
  type        = string
  description = "network security group"
}

variable "vnetname" {
  type        = string
  description = "virtual network"
}


variable "address_space" {
  type        = list(string)
  description = "iprange"
}

variable "dns_servers" {
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