variable "location" {
  type        = string
  description = "location of resources"
  default     = "westeurope"
}

variable "sa_web" {
  type        = string
  description = "name of sa"
  default     = "saweb"
}

variable "rg_web" {
  type        = string
  description = "name of rg for web"
  default     = "rg_webjhl1"
}

variable "index_document" {
  type        = string
  description = "name of index content"
  default     = "index.html"
}