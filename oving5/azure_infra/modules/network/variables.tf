variable "location" {
  type    = string
  default = "West Europe"
}

variable "nsgname" {
  type    = string
  default = "nsg-jhl-0"
}

variable "vnetname" {
  type    = string
  default = "vnet-jhl-0"
}

variable "rgname" {
  type        = string
  description = "resource group name"
  default     = "rg-jhl-0"
}

variable "subnetname" {
  type        = string
  description = "subnet name"
  default     = "sub-jhl-0"
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
  default     = "pubip-jhl0"
}

variable "domain_name_label" {
  type        = string
  description = "Label for domain"
  default     = "jhl-domain-0"
}

#tags
variable "common_tags" {
  type = map(string)
}
