variable "saname" {
  type        = string
  description = "storage account name"
  default     = "sajhl0"
}

variable "rgname" {
  type        = string
  description = "resource group name"
  default     = "rg-jhl-0"
}

variable "location" {
  type        = string
  description = "location of resources"
  default     = "West Europe"
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

#tags
variable "common_tags" {
  type = map(string)
}
