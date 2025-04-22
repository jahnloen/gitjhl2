variable "location" {
    type = string
    description = "location of resources"
}

variable "sa_web" {
    type = string
    description = "name of sa"
}

variable "rg_web" {
  type = string
  description = "name of rg for web"
  default = "rg_webjhl1"
}

variable "index_document" {
    type = string
    description = "name of index content"
}