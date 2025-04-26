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

variable "source_content" {
  type = string
  description = "content of index.html "
  default = "<h1>Made with Terraform - CI/CD - update del 2</h1>"
}

variable "index_document" {
  type        = string
  description = "name of index content"
  default     = "index.html"
}