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

variable "subscription_id" {
  type        = string
  description = "abonnements id"
}              