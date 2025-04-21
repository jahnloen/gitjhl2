variable "location" {
  type    = string
  default = "West Europe"
}

variable "rgname" {
  type        = string
  description = "resource group name"
  default     = "rg-jhl-0"
}

variable "vmssinstances" {
  type        = number
  description = "number of vmss instances"
  default     = 0
}

variable "vmssname" {
  description = "virtual machine scaleset name"
  type        = string
  default     = "vmss-jhl-0"
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
  default     = "" #dette betyr blank/tom verdi
}

#tags
variable "common_tags" {
  type = map(string)
}
