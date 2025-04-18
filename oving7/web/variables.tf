variable "location" {
    type = string
    description = "location of resources"
}

variable "sa_name" {
    type = string
    description = "name of sa"
}

variable "rg_name" {
  type = string
  description = "name of rg"
}

variable "index_document" {
    type = string
    description = "name of index content"
}

variable "source_content" {
    type = string
    description = "source content for index.html file"
}