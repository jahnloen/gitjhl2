variable "location" {
  type    = string
  default = "West Europe"
}

variable "rgname" {
  type        = string
  description = "resource group name"
  default     = "rg-jhl-0"
}

variable "vmname" {
  description = "virtual machine name"
  type        = string
  default     = "vm-jhl-0"
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
  default     = "" #blank/tom verdi
}

variable "public_ip_id" {
  type    = string
  default = "" #blank/tom verdi
}

#tags
variable "common_tags" {
  type = map(string)
}
