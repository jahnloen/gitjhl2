locals {

  common_tags = {
    company      = var.company
    project      = "${var.project}-${var.company}"
    billing_code = var.billing_code
    cost_center  = var.cost_center
    owner        = var.owner
    location     = var.location
  }
}

#sjekk locals før kjøring terraform console > linjeshift local.common_tags