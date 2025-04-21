#denne fila brukes i forbindelse med midlertidige variabler 
#eller beregninger som krever input eller bruker andre variabler
#tags
#dynamiske ressurs navn, feks. storage accounts
#forenkling av logikk
#kombinere flere variabler
#environment (miljøvariabler)

locals {

  common_resource_group_name = var.resource_group_name
  common_location            = var.location
  storage_account_name       = "sajhl${var.environment}"
  networkrg_name       = "networkrgjhl${var.environment}"

  common_tags = {
    company      = var.company
    project      = "${var.project}${var.company}"
    billing_code = var.billing_code
    cost_center  = var.cost_center
    owner        = var.owner
    location     = "West Europe"
  }

}