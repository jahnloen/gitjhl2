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

variable "workspace_name" {
  type = string
  description = "workspace name, ie. dev, test and prod"  #value to be entered manually to separate backends for each workspace
}

#variable "source_content" {
#    type = string
#    description = "source content for index.html file"
#}